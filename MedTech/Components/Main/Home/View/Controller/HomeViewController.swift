//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let userDefaults = UserDefaultsService()
    private let viewModel: HomeViewModelProtocol
    
    private let appointmentsViewModel: AppointmentViewModelProtocol
    
    let notificationsView = NotificationsViewController()
    
    var model = [WeekModel]()
    
    var selectedWeek = 1
    var currentWeek = 1
    
    init(vm: HomeViewModelProtocol = HomeViewModel(), vm2: AppointmentViewModelProtocol = AppointmentViewModel()) {
        viewModel = vm
        appointmentsViewModel = vm2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionViewCell.self)
        return cv
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: "homePageCell")
        return tableView
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
        button.tintColor = UIColor(named: "Violet")
        button.frame = CGRect(x: 0, y: 0, width: 220, height: 220)
        button.addTarget(self, action: #selector(didTapNotificationsButton), for: .touchUpInside)
        return button
    }()
    
    lazy var sosButton : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Peach")
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        return button
    }()
    
    lazy var remindButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.setTitle(" Следующее посещение 30-июля - 07:00", for: .normal)
        button.backgroundColor = UIColor(named: "Violet")
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 14)
        button.setTitleColor(.white , for: .normal)
        button.addTarget(self, action: #selector(didTapRemindButton), for: .touchUpInside)
        return button
    }()
    
    let topic : UIView = {
        let vieww = UIView()
        vieww.layer.cornerRadius = 30
        vieww.backgroundColor = .white
        vieww.translatesAutoresizingMaskIntoConstraints = false
        return vieww
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !model.isEmpty {
            collectionView.scrollToItem(at: [0, selectedWeek], at: .centeredHorizontally, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Главная"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: notificationsButton)
        
        collectionView.showsHorizontalScrollIndicator = false
        setUpSubViews()
        setUpConstraints()
        appointmentsViewModel.getLastVisit(id: 2) { rs in
            if rs != nil {
                self.remindButton.isHidden = false
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let dateDate = dateFormatter.date(from: (rs?.dateVisit)!)
                dateFormatter.dateFormat = "dd-MMM"
                dateFormatter.locale = Locale(identifier: "ru")
                let dateString = dateFormatter.string(from: dateDate!)
                self.remindButton.setTitle("Следующее посещение \(dateString) - \(rs!.visitStartTime.dropLast(3))", for: .normal)
            } else {
                DispatchQueue.main.async {
                    self.remindButton.isHidden = true
                }
                
            }
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getLastVisit()
        getAllWeeks()
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        showBadge(withCount: 5)
        
        viewModel.getClinic { result in
            guard let result = result else {
                return
            }
            self.userDefaults.saveEmergency(phone: (result.emergencyPhoneNumber)!)
            self.userDefaults.saveReception(phone: (result.receptionPhoneNumber)!)
        }
    }
    
    @objc func didTapSosButton() {
        let number = userDefaults.getEmergency()
        callNumber(phoneNumber: number)
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func sortAnArrayOfArray(_ mod: [WeekModel]) {
        for i in 0...model.count - 1 {
            let dto = model[i].weeksOfBabyDevelopmentDTOS
            let sortedArray = dto?.sorted(by: { itemA, itemB in
                return itemA.id < itemB.id
            })
            model[i].weeksOfBabyDevelopmentDTOS?.removeAll()
            model[i].weeksOfBabyDevelopmentDTOS?.append(contentsOf: sortedArray!)
        }
    }
    
    func getLastVisit() {
        let userId = userDefaults.getUserId()
        appointmentsViewModel.getLastVisit(id: userId) { rs in
            if rs != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateDate = dateFormatter.date(from: (rs?.dateVisit)!)
                dateFormatter.dateFormat = "dd-MMM"
                dateFormatter.locale = Locale(identifier: "ru")
                let dateString = dateFormatter.string(from: dateDate!)
                self.remindButton.setTitle(" Следующее посещение \(dateString) - \(rs!.visitStartTime.dropLast(3))", for: .normal)
            }
        }
    }
    
    func getAllWeeks() {
        viewModel.getAllWeeks { result in
            if !result!.isEmpty {
                DispatchQueue.main.async {
                    self.model = result!
                    self.sortAnArrayOfArray(self.model)
                    if !self.model.isEmpty {
                        let size = 250 * (self.model[self.selectedWeek].weeksOfBabyDevelopmentDTOS!.count)
                        self.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + CGFloat(size))
                    }
                    self.scrollView.contentSize = self.contentSize
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func setUpSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(
            remindButton,
            collectionView,
            tableView
        )
    }
    
    @objc func didTapNotificationsButton(){
        let loadVC = NotificationsViewController()
        loadVC.modalPresentationStyle = .fullScreen
        self.present(loadVC, animated: true, completion: nil)
    }
    
    
    let badgeSize: CGFloat = 13
    let badgeTag = 9830384
    
    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        badgeCount.text = String(count)
        return badgeCount
    }
    
    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        notificationsButton.addSubview(badge)
        
        NSLayoutConstraint.activate([
            notificationsButton.widthAnchor.constraint(equalToConstant: 25),
            notificationsButton.heightAnchor.constraint(equalToConstant: 25),
            
            badge.leftAnchor.constraint(equalTo: notificationsButton.leftAnchor, constant: 14),
            badge.topAnchor.constraint(equalTo: notificationsButton.topAnchor, constant: -4),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }
    
    @objc func didTapRemindButton() {
        tabBarController?.selectedIndex = 1
    }
    
    func setUpConstraints() {
        notificationsButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
        }
        remindButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(336)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(remindButton.snp.top).inset(60)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().inset(3)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1000)
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(CollectionViewCell.self, indexPath: indexPath)
        if indexPath.row == selectedWeek {
            //cell.changeSelected()
            let circlePath = UIBezierPath(arcCenter: cell.center,
                                          radius: cell.frame.width / 2 - 1,
                                          startAngle: -(.pi / 2),
                                          endAngle: .pi * 2,
                                          clockwise: true)
            
            
            let trackShape = CAShapeLayer()
            trackShape.path = circlePath.cgPath
            trackShape.fillColor = UIColor.clear.cgColor
            trackShape.strokeColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1).cgColor
            trackShape.lineWidth = 2
            cell.layer.addSublayer(trackShape)
            
            let shape = CAShapeLayer()
            shape.path = circlePath.cgPath
            shape.lineWidth = 2
            shape.strokeColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1).cgColor
            shape.strokeEnd = 0.4
            shape.fillColor = UIColor.clear.cgColor
            
            cell.layer.addSublayer(shape)
        }
        //        if !model.isEmpty {
        //            if indexPath.row < currentWeek {
        //                cell.setBeforeDate(text: model[indexPath.row].weekday)
        //            } else {
        //                cell.fill(text: model[indexPath.row].weekday)
        //            }
        //        }
        
        //        let circlePath = UIBezierPath(arcCenter: cell.center,
        //                                      radius: cell.frame.width / 2 - 1,
        //                                      startAngle: -(.pi / 2),
        //                                      endAngle: .pi * 2,
        //                                      clockwise: true)
        //
        //
        //        let trackShape = CAShapeLayer()
        //        trackShape.path = circlePath.cgPath
        //        trackShape.fillColor = UIColor.clear.cgColor
        //        trackShape.strokeColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1).cgColor
        //        trackShape.lineWidth = 2
        //        cell.layer.addSublayer(trackShape)
        //
        //        let shape = CAShapeLayer()
        //        shape.path = circlePath.cgPath
        //        shape.lineWidth = 2
        //        shape.strokeColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1).cgColor
        //        shape.strokeEnd = 0.4
        //        shape.fillColor = UIColor.clear.cgColor
        //
        //        cell.layer.addSublayer(shape)
        cell.fill(text: model[indexPath.row].weekday)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWeek = model[indexPath.row].weekday - 1
        if !model.isEmpty {
            collectionView.scrollToItem(at: [0, selectedWeek], at: .centeredHorizontally, animated: true)
        }
        tableView.reloadData()
        collectionView.reloadData()
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !model.isEmpty {
            return model[selectedWeek].weeksOfBabyDevelopmentDTOS!.count
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homePageCell", for: indexPath) as! WeekTableViewCell
        if !model.isEmpty {
            let data = model[selectedWeek].weeksOfBabyDevelopmentDTOS![indexPath.row]
            cell.setUpData(titleLabel: data.header!, image: data.imageUrl!, description: data.description!)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func getReuseCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        indexPath: IndexPath
    ) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! Cell
    }
}

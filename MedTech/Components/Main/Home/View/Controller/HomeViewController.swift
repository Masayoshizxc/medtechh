//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    
    private var viewModel: HomeViewModelProtocol
    private let appointmentsViewModel: AppointmentViewModelProtocol
    
    let notificationsView = NotificationsViewController()
        
    var selectedWeek = 0
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
        view.refreshControl = UIRefreshControl()
        view.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionViewCell.self)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: "homePageCell")
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        return tableView
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Icons.notification.image, for: .normal)
        button.tintColor = UIColor(named: "Violet")
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
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
        button.setImage(Icons.calendarTime.image, for: .normal)
        button.setTitle(" Следующее посещение 30-июля - 07:00", for: .normal)
        button.backgroundColor = UIColor(named: "Violet")
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 14)
        button.setTitleColor(.white , for: .normal)
        button.addTarget(self, action: #selector(didTapRemindButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let topic : UIView = {
        let vieww = UIView()
        vieww.layer.cornerRadius = 30
        vieww.backgroundColor = .white
        vieww.translatesAutoresizingMaskIntoConstraints = false
        return vieww
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Главная"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: notificationsButton)
        
        DispatchQueue.main.async {
            self.getLastVisit()
            self.getAllWeeks()
            self.viewModel.getClinic()
        }
        showBadge(withCount: 0)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didChangeWeekToLeft))
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didChangeWeekToRight))
        leftSwipeGesture.direction = .right
        rightSwipeGesture.direction = .left
        tableView.addGestureRecognizer(leftSwipeGesture)
        tableView.addGestureRecognizer(rightSwipeGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getLastVisit()
        viewModel.getNotifications { result in
            switch result {
            case .success:
                guard let notfCount = UserDefaultsService.shared.getNotificationCount() else {
                    self.showBadge(withCount: self.viewModel.notifications!.count)
                    return
                }
                let count = self.viewModel.notifications!.count - notfCount
                self.showBadge(withCount: count)
            case .failure:
                print("There was a problem with downloading Notifications")
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpSubViews()
        setUpConstraints()
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
    
    @objc func didChangeWeekToLeft() {
        guard selectedWeek >= 1 else {
            return
        }
        selectedWeek -= 1
        collectionView.selectItem(at: [0, selectedWeek], animated: true, scrollPosition: .centeredHorizontally)
        resize()
        tableView.reloadData()
    }
    
    @objc func didChangeWeekToRight() {
        guard let model = viewModel.model else {
            return
        }
        guard selectedWeek < model.count - 1 else {
            return
        }
        selectedWeek += 1
        collectionView.selectItem(at: [0, selectedWeek], animated: true, scrollPosition: .centeredHorizontally)
        resize()
        tableView.reloadData()
    }
    
    @objc func didPullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getLastVisit()
            self.getAllWeeks()
            self.viewModel.getClinic()
            self.collectionView.reloadData()
            self.tableView.reloadData()
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func didTapSosButton() {
        let number = userDefaults.getEmergency()
        callNumber(phoneNumber: number)
    }
    
    private func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func getLastVisit() {
        let userId = userDefaults.getUserId()
        appointmentsViewModel.getLastVisit(id: userId) { [weak self] rs in
            if rs != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateDate = dateFormatter.date(from: (rs?.dateVisit)!)
                dateFormatter.dateFormat = "dd LLL"
                dateFormatter.locale = Locale(identifier: "ru")
                let dateString = dateFormatter.string(from: dateDate!)
                self?.remindButton.setTitle(" Следующее посещение \(dateString.capitalized.dropLast()) - \(rs!.visitStartTime.dropLast(3))", for: .normal)
                self?.remindButton.isHidden = false
            } else {
                DispatchQueue.main.async {
                    self?.remindButton.isHidden = false
                    self?.remindButton.setTitle(" Следующих посешений нету", for: .normal)
                }
            }
        }
    }
    
    func getAllWeeks() {
        viewModel.getAllWeeks { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            if result == .success {
                if !strongSelf.viewModel.model!.isEmpty {
                    strongSelf.resize()
                } else {
                    strongSelf.collectionView.reloadData()
                    strongSelf.tableView.reloadData()
                }
            } else {
                print("There was an error with downloading")
            }
            
        }
    }
    
    func resize() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if !strongSelf.viewModel.model!.isEmpty {
                let size = 350 * (strongSelf.viewModel.model![strongSelf.selectedWeek].weeksOfBabyDevelopmentDTOS!.count)
                strongSelf.contentSize = CGSize(width: strongSelf.view.frame.width, height: strongSelf.view.frame.height + CGFloat(size))
            }
            strongSelf.scrollView.contentSize = strongSelf.contentSize
            strongSelf.containerView.frame.size = strongSelf.contentSize
            strongSelf.collectionView.reloadData()
            strongSelf.collectionView.selectItem(at: [0, strongSelf.selectedWeek], animated: true, scrollPosition: .centeredHorizontally)
            strongSelf.tableView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    @objc func didTapNotificationsButton(){
        let loadVC = NotificationsViewController()
        guard let model = viewModel.notifications else {
            return
        }
        loadVC.model = model.reversed()
        self.present(loadVC, animated: true, completion: nil)
    }
    
    
    let badgeSize: CGFloat = 12
    let badgeTag = 9830384
    
    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.width / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(11)
        badgeCount.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        badgeCount.text = String(count)
        return badgeCount
    }
    
    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: 0)
        if count >= 0 {
            badge.text = String(count)
        } else {
            badge.text = "0"
        }
        
        notificationsButton.addSubview(badge)
        
        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: notificationsButton.leftAnchor, constant: 13),
            badge.topAnchor.constraint(equalTo: notificationsButton.topAnchor, constant: -2),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }
    
    @objc func didTapRemindButton() {
        let vc = AppointmentViewController()
        vc.nextDate = "2022-08-31"
        tabBarController?.selectedIndex = 1
    }
    
    func setUpConstraints() {
        notificationsButton.snp.makeConstraints{make in
            make.width.height.equalTo(25)
        }
        remindButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(remindButton.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(7)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            //make.height.equalTo(1200)
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.model != nil else {
            return 0
        }
        return viewModel.model!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(CollectionViewCell.self, indexPath: indexPath)
        guard let model = viewModel.model else {
            return cell
        }
        
        if !model.isEmpty {
            if indexPath.row + 1 == currentWeek {
                cell.setBeforeDate(text: model[indexPath.row].weekday)
            } else {
                cell.fill(text: model[indexPath.row].weekday)
            }
        }
        
//        if viewModel.model![indexPath.row].weekday == currentWeek {
//            cell.addProgressBar(strokeEnd: 0.7)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWeek = viewModel.model![indexPath.row].weekday - 1
        if !viewModel.model!.isEmpty {
            collectionView.selectItem(at: [0, selectedWeek], animated: true, scrollPosition: .centeredHorizontally)
            resize()
        }
        tableView.reloadData()
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.model!.isEmpty {
            if viewModel.model![selectedWeek].weeksOfBabyDevelopmentDTOS!.count == 0 {
                return 1
            } else {
                return viewModel.model![selectedWeek].weeksOfBabyDevelopmentDTOS!.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homePageCell", for: indexPath) as! WeekTableViewCell
        if !viewModel.model!.isEmpty{
            guard viewModel.model![selectedWeek].weeksOfBabyDevelopmentDTOS?.count != 0 else {
                cell.setUpData(titleLabel: nil, image: nil, description: nil)
                return cell
            }
            let data = viewModel.model![selectedWeek].weeksOfBabyDevelopmentDTOS![indexPath.row]
            guard let imageUrl = data.imageUrl else {
                return cell
            }
            cell.setUpData(titleLabel: data.header!, image: imageUrl, description: data.description!)
        }
        return cell
    }
    
}

extension UINavigationController {
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(50)
        navigationBar.frame = CGRect(x: 0, y: heightComputed(43), width: view.frame.width, height: height)
    }
}

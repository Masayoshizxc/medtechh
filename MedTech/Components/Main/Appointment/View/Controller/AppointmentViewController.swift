//
//  AppointentViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import Toast_Swift

class AppointmentViewController: BaseViewController {
    
    private var viewModel: AppointmentViewModelProtocol
    
    init(vm: AppointmentViewModelProtocol = AppointmentViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userDefaults = UserDefaultsService()
    var selectedDate = Date()
    var days = [Day]()
    let dateFormatter = DateFormatter()
    var nextDate: String?
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
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
    
    private lazy var collectionViewA: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCollectionViewCell.self)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var collectionViewB: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TimeCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let monthView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.988, green: 0.816, blue: 0.812, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Feb 2022"
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    private lazy var leftArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(named: "Violet")
        button.addTarget(self, action: #selector(didTapLeftArrow), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(named: "Violet")
        button.addTarget(self, action: #selector(didTapRightArrow), for: .touchUpInside)
        return button
    }()
    
    private let monday: UILabel = {
        let label = UILabel()
        label.text = "Пн"
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        return label
    }()
    
    private let tuesday: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        return label
    }()
    
    private let wendnesday: UILabel = {
        let label = UILabel()
        label.text = "Ср"
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        return label
    }()
    
    private let thursday: UILabel = {
        let label = UILabel()
        label.text = "Чт"
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        return label
    }()
    
    private let friday: UILabel = {
        let label = UILabel()
        label.text = "Пт"
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        return label
    }()
    
    private let saturday: UILabel = {
        let label = UILabel()
        label.text = "Сб"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let sunday: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [monday,
         tuesday,
         wendnesday,
         thursday,
         friday,
         saturday,
         sunday].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var sosButton4 : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(named: "Peach")
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var callButton : UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.setImage(Icons.call.image, for: .normal)
        button.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать время"
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var appointButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Записаться", for: .normal)
        button.addTarget(self, action: #selector(didTapAppointButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Violet")
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let appointmentView: AppointmentView = {
        let view = AppointmentView()
        view.backgroundColor = UIColor(named: "Violet")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Запись"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: callButton)
        
        viewModel.getDoctorId()
        
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
        appointmentView.isHidden = true
        
        setSwipes()
        
        setMonthView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(
            monthView,
            monthLabel,
            leftArrow,
            rightArrow,
            stackView,
            collectionViewA,
            collectionViewB,
            timeLabel,
            appointButton,
            appointmentView
        )
        setUpConstraints()
    }
    
    
    @objc func didTapSosButton() {
        let number = userDefaults.getEmergency()
        callNumber(phoneNumber: number)
    }
    
    @objc func didTapCallButton() {
        let number = userDefaults.getReception()
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
    
    func setSwipes() {
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didTapRightArrow))
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didTapLeftArrow))
        let rightSwipeRecognizer2 = UISwipeGestureRecognizer(target: self, action: #selector(didTapRightArrow))
        let leftSwipeRecognizer2 = UISwipeGestureRecognizer(target: self, action: #selector(didTapLeftArrow))
        rightSwipeRecognizer.direction = .left
        leftSwipeRecognizer.direction = .right
        rightSwipeRecognizer2.direction = .left
        leftSwipeRecognizer2.direction = .right
        collectionViewA.addGestureRecognizer(rightSwipeRecognizer)
        collectionViewA.addGestureRecognizer(leftSwipeRecognizer)
        monthView.addGestureRecognizer(rightSwipeRecognizer2)
        monthView.addGestureRecognizer(leftSwipeRecognizer2)
        
        monthView.isUserInteractionEnabled = true
        collectionViewA.isUserInteractionEnabled = true
    }
    
    
    func setMonthView() {
        days.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        var count: Int = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                days.append(Day(date: ""))
            }
            else {
                days.append(Day(date: String(count - startingSpaces)))
            }
            count += 1
        }
        
        if days[0].date == "2" {
            days.insert(Day(date: "1"), at: 0)
            days.insert(Day(date: ""), at: 0)
            days.insert(Day(date: ""), at: 0)
            days.insert(Day(date: ""), at: 0)
            days.insert(Day(date: ""), at: 0)
            days.insert(Day(date: ""), at: 0)
            days.insert(Day(date: ""), at: 0)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).capitalized
        + " " + CalendarHelper().yearString(date: selectedDate)
        collectionViewA.reloadData()
    }
    
    @objc func didTapLeftArrow() {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        collectionViewA.reloadData()
        setMonthView()
        appointmentView.isHidden = true
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
    }
    
    @objc func didTapRightArrow() {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        collectionViewA.reloadData()
        setMonthView()
        appointmentView.isHidden = true
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
    }
    
    @objc func didTapAppointButton() {
        guard userDefaults.getTime() != nil else {
            return
        }
        let sheet = UIAlertController(title: "Записаться", message: "Вы уверены что вы хотите записаться?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
            self?.containerView.makeToastActivity((self?.view.center)!)
            self?.viewModel.postAppointments() { result in
                guard let strongSelf = self else {
                    return
                }
                
                if result == .success {
                    guard let postAppointment = strongSelf.viewModel.postAppointment else {
                        return
                    }
                    DispatchQueue.main.async {
                        strongSelf.scrollView.makeToast("Вы успешно записались на прием!", point: strongSelf.collectionViewB.center, title: nil, image: nil, completion: nil)
                        strongSelf.appointmentView.getData(model: postAppointment)
                        strongSelf.containerView.hideToastActivity()
                        strongSelf.timeLabel.isHidden = true
                        strongSelf.collectionViewB.isHidden = true
                        strongSelf.appointButton.isHidden = true
                        strongSelf.appointmentView.isHidden = false
                        strongSelf.dismiss(animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.scrollView.makeToast("Вы не можете записаться на пройденный день!", point:strongSelf.collectionViewB.center, title: nil, image: nil, completion: nil)
                        strongSelf.containerView.hideToastActivity()
                        strongSelf.dismiss(animated: true)
                    }
                }
            }
        }))
        present(sheet, animated: true)
    }
    
    
    func setUpConstraints() {
        monthView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            //make.width.equalTo(336)
            make.left.right.equalTo(collectionViewA)
            make.height.equalTo(44)
        }
        monthLabel.snp.makeConstraints { make in
            make.center.equalTo(monthView.snp.center)
        }
        
        leftArrow.snp.makeConstraints { make in
            make.centerY.equalTo(monthView.snp.centerY)
            make.left.equalTo(monthView).inset(35)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        rightArrow.snp.makeConstraints { make in
            make.centerY.equalTo(monthView.snp.centerY)
            make.right.equalTo(monthView).inset(35)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom).offset(30)
            //make.centerX.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(17)
            //make.width.equalToSuperview().offset(-5)
        }
        
        collectionViewA.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(17)
            make.height.equalTo(300)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewA.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        collectionViewB.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
        
        appointButton.snp.makeConstraints { make in
            make.top.equalTo(collectionViewB.snp.bottom).offset(30)
            make.width.equalTo(336)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        appointmentView.snp.makeConstraints { make in
            make.top.equalTo(collectionViewA.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
            make.left.right.equalTo(collectionViewA)
            make.height.equalTo(254)
        }
        
    }
}

extension AppointmentViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewA:
            return days.count
        case collectionViewB:
            return viewModel.freeTimes.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionViewA:
            let cell = collectionView.getReuseCell(CalendarCollectionViewCell.self, indexPath: indexPath)
            cell.getData(string: days[indexPath.row].date)
            dateFormatter.dateFormat = "yyyy-MM"
            let monthYear = dateFormatter.string(from: selectedDate)
            let day = days[indexPath.row].date
            guard !day.isEmpty else {
                cell.backgroundColor = .white
                return cell
            }
            let dayString = day.count < 2 ? "0\(day)" : day
            let date = "\(monthYear)-\(dayString)"
            
            if date == nextDate {
                print("Hey Hey")
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let datedate = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "e"
            let langStr = Locale.current.languageCode
            let doctorId = userDefaults.getDoctorId()
            if doctorId != nil {
                DispatchQueue.main.async {
                    self.viewModel.getReservedDates(date: "\(monthYear)-01") { result in
                        guard let reservedDate = self.viewModel.reservedDates?.reservedDates else {
                            return
                        }
                        switch result {
                        case .success:
                            for res in reservedDate {
                                if date == res {
                                    cell.changeColorToGrey()
                                }
                            }
                        case .failure:
                            print("Error getting reserved dates")
                        case .none:
                            break
                        }
                    }
                }
            }
            
            let dateStr = langStr == "ru" ? Int(dateFormatter.string(from: datedate!))! : Int(dateFormatter.string(from: datedate!))!
            if days[indexPath.row].isSelected == true {
                cell.backgroundColor = UIColor(named: "Violet")
                cell.changeColor()
                days[indexPath.row].isSelected = false
            } else {
                if dateStr == 6 || dateStr == 7 {
                    cell.backgroundColor = .white
                    cell.changeColorToRed()
                } else {
                    cell.backgroundColor = .white
                    cell.changeColorToDefault()
                }
            }
            cell.layer.cornerRadius = cell.frame.width / 2
            return cell
        case collectionViewB:
            let cell = collectionView.getReuseCell(TimeCollectionViewCell.self, indexPath: indexPath)
            cell.getData(string: viewModel.freeTimes[indexPath.row].time)
            cell.layer.borderWidth = 0.25
            if viewModel.freeTimes[indexPath.row].isSelected == true {
                cell.backgroundColor = UIColor(named: "Violet")
                cell.changeColor()
                viewModel.freeTimes[indexPath.row].isSelected = false
            } else {
                cell.backgroundColor = .white
                cell.changeColorToDefault()
            }
            cell.layer.cornerRadius = 16
            return cell
        default:
            let cell = collectionView.getReuseCell(UICollectionViewCell.self, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionViewA:
            dateFormatter.dateFormat = "yyyy-MM"
            let monthYear = dateFormatter.string(from: selectedDate)
            let day = days[indexPath.row].date
            let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
            guard !day.isEmpty else {
                return
            }
            viewModel.freeTimes.removeAll()
            scrollView.isScrollEnabled = true
            self.userDefaults.saveTime(time: nil)
            let dayString = day.count < 2 ? "0\(day)" : day
            let date = "\(monthYear)-\(dayString)"
            self.userDefaults.saveDate(date: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let datedate = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "ee"
            let langStr = Locale.current.languageCode
            guard let datedate = datedate else {
                return
            }
            let dateStr = langStr == "ru" ? Int(dateFormatter.string(from: datedate))! : Int(dateFormatter.string(from: datedate))!
            viewModel.getVisit(date: date) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success:
                    guard let patientVisit = strongSelf.viewModel.patientVisit else {
                        return
                    }
                    strongSelf.appointmentView.isHidden = false
                    strongSelf.timeLabel.isHidden = true
                    strongSelf.collectionViewB.isHidden = true
                    strongSelf.appointButton.isHidden = true
                    strongSelf.appointmentView.getData(model: patientVisit)
                case .failure:
                    strongSelf.viewModel.getFreeTimes(weekday: String(dateStr)) { rslt in
                        if rslt == .success {
                            strongSelf.viewModel.getNonFreeTimes(date: date) { res in
                                DispatchQueue.main.async {
                                    strongSelf.appointmentView.isHidden = true
                                    strongSelf.timeLabel.isHidden = false
                                    strongSelf.collectionViewB.isHidden = false
                                    strongSelf.appointButton.isHidden = false
                                    strongSelf.collectionViewB.reloadData()
                                }
                            }
                        } else {
                            strongSelf.appointmentView.isHidden = true
                            strongSelf.timeLabel.isHidden = true
                            strongSelf.collectionViewB.isHidden = true
                            strongSelf.appointButton.isHidden = true
                        }
                    }
                default:
                    break
                }
            }
            cell.backgroundColor = .white
            days[indexPath.row].isSelected = true
            collectionViewA.reloadData()
        case collectionViewB:
            appointButton.isHidden = false
            let time = viewModel.freeTimes[indexPath.row].time
            self.userDefaults.saveTime(time: time)
            viewModel.freeTimes[indexPath.row].isSelected = true
            collectionViewB.reloadData()
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case collectionViewA:
            let width = (collectionViewA.frame.size.width - 20) / 8
            return CGSize(width: width, height: width)
        case collectionViewB:
            return CGSize(width: 65, height: 44)
        default:
            return CGSize(width: 50, height: 50)
        }
    }
    
}

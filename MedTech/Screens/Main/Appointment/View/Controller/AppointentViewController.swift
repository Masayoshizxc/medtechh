//
//  AppointentViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class AppointentViewController: UIViewController {
    
    var selectedDate = Date()
    var days = [Day]()
    var freeTimes = [Time]()
    
    let collectionViewA: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CalendarCollectionViewCell.self)
        return cv
    }()
    
    let collectionViewB: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TimeCollectionViewCell.self)
        return cv
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
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private lazy var leftArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        button.addTarget(self, action: #selector(didTapLeftArrow), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        button.addTarget(self, action: #selector(didTapRightArrow), for: .touchUpInside)
        return button
    }()
    
    private let monday: UILabel = {
        let label = UILabel()
        label.text = "Пн"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private let tuesday: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private let wendnesday: UILabel = {
        let label = UILabel()
        label.text = "Ср"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private let thursday: UILabel = {
        let label = UILabel()
        label.text = "Чт"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private let friday: UILabel = {
        let label = UILabel()
        label.text = "Пт"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        return label
    }()
    
    private let saturday: UILabel = {
        let label = UILabel()
        label.text = "Сб"
        label.textColor = .red
        return label
    }()
    
    private let sunday: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        label.textColor = .red
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        //stack.spacing = 37.0
        stack.alignment = .fill
        stack.distribution = .fillProportionally
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
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
//        button.setTitleShadowColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        //button.layer.shadowOffset = CGSize(width: 0, height: 4)
        //button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        //button.layer.shadowOpacity = 1.0
        //button.layer.shadowRadius = 16
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
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var appointButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Записаться", for: .normal)
        button.addTarget(self, action: #selector(didTapAppointButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let appointmentView: AppointmentView = {
        let view = AppointmentView()
        view.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Запись"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: callButton)
        
        collectionViewA.backgroundColor = .white
        collectionViewA.isScrollEnabled = false
        collectionViewA.delegate = self
        collectionViewA.dataSource = self
        
        collectionViewB.backgroundColor = .white
        collectionViewB.isScrollEnabled = false
        collectionViewB.delegate = self
        collectionViewB.dataSource = self
        
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
        appointmentView.isHidden = true
        
        setMonthView()
        freeTimes.append(Time(time: "10:00"))
        freeTimes.append(Time(time: "11:00"))
        freeTimes.append(Time(time: "12:00"))
        freeTimes.append(Time(time: "14:00"))
        freeTimes.append(Time(time: "15:00"))
        freeTimes.append(Time(time: "16:00"))
        freeTimes.append(Time(time: "17:00"))
        freeTimes.append(Time(time: "18:00"))
        
                                 
        view.addSubviews(
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
        print("SOS button tapped")
    }
    
    @objc func didTapCallButton() {
        print("Call button tapped")
        let vc = CallViewController()
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
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
            print("Hell yea")
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).capitalized
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionViewA.reloadData()
    }
    
    @objc func didTapLeftArrow() {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
        appointmentView.isHidden = true
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
    }
    
    @objc func didTapRightArrow() {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
        appointmentView.isHidden = true
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
    }
    
    @objc func didTapAppointButton() {
        print("Appoint button tapped!!!")
        timeLabel.isHidden = true
        collectionViewB.isHidden = true
        appointButton.isHidden = true
        appointmentView.isHidden = false
    }
    
    func setUpConstraints() {
        monthView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(44)
        }
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.centerX.equalToSuperview()
        }
        
        leftArrow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.right.equalTo(monthView.snp.left).offset(40)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        rightArrow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.left.equalTo(monthView.snp.right).offset(-40)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-5)
        }
        
        collectionViewA.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
            make.top.equalTo(collectionViewA.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(254)
            make.width.equalTo(336)
        }
        
    }
}

extension AppointentViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewA {
            return days.count
        } else {
            return freeTimes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewA {
            let cell = collectionView.getReuseCell(CalendarCollectionViewCell.self, indexPath: indexPath)
            cell.getData(string: days[indexPath.row].date)

            if days[indexPath.row].isSelected == true {
                cell.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
                cell.changeColor()
                days[indexPath.row].isSelected = false
            } else {
                cell.backgroundColor = .white
                cell.changeColorToDefault()
            }
            cell.layer.cornerRadius = cell.frame.height / 2
            return cell
        } else {
            let cell = collectionView.getReuseCell(TimeCollectionViewCell.self, indexPath: indexPath)
            cell.getData(string: freeTimes[indexPath.row].time)
            if freeTimes[indexPath.row].isSelected == true {
                cell.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
                cell.changeColor()
                freeTimes[indexPath.row].isSelected = false
            } else {
                cell.backgroundColor = .white
                cell.changeColorToDefault()
            }
            cell.layer.cornerRadius = 16
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewA {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let monthYear = dateFormatter.string(from: selectedDate)
            let day = days[indexPath.row].date
            let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
            if day != "" {
                appointmentView.isHidden = true
                timeLabel.isHidden = false
                collectionViewB.isHidden = false
                //appointButton.isHidden = false
                let dayString = day.count < 2 ? "0\(day)" : day
                let date = "\(monthYear)-\(dayString)"
                print(date)
                cell.backgroundColor = .white
                days[indexPath.row].isSelected = true
                collectionViewA.reloadData()
            }
        } else {
            appointButton.isHidden = false
            print(freeTimes[indexPath.row].time)
            freeTimes[indexPath.row].isSelected = true
            collectionViewB.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewA {
            let width = (collectionViewA.frame.size.width - 20) / 8
            let height = (collectionViewA.frame.size.height + 80) / 8
            return CGSize(width: width, height: height)
            //return CGSize(width: 40, height: 44)
        } else {
            return CGSize(width: 65, height: 44)
        }
    }
    
}

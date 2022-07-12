//
//  AppointentViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class AppointentViewController: UIViewController {
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
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
        return label
    }()
    
    private let tuesday: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        return label
    }()
    
    private let wendnesday: UILabel = {
        let label = UILabel()
        label.text = "Ср"
        return label
    }()
    
    private let thursday: UILabel = {
        let label = UILabel()
        label.text = "Чт"
        return label
    }()
    
    private let friday: UILabel = {
        let label = UILabel()
        label.text = "Пт"
        return label
    }()
    
    private let saturday: UILabel = {
        let label = UILabel()
        label.text = "Сб"
        return label
    }()
    
    private let sunday: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30.0
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
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать время"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Запись"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //setCellsView()
        setMonthView()
        
        view.addSubviews(monthView, monthLabel, leftArrow, rightArrow, stackView, collectionView, timeLabel)
        setUpConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        //collectionView.frame = view.bounds
    }
    
    @objc func didTapSosButton() {
        print("SOS button tapped")
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.width - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        var count: Int = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).capitalized
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        print(totalSquares)
    }
    
    @objc func didTapLeftArrow() {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @objc func didTapRightArrow() {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
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
            make.right.equalTo(monthLabel.snp.left).offset(-80)
        }
        
        rightArrow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.left.equalTo(monthLabel.snp.right).offset(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(15)
            make.width.equalToSuperview().offset(-5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(380)
            make.width.equalTo(380)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

extension AppointentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(CalendarCollectionViewCell.self, indexPath: indexPath)
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCollectionViewCell
        cell.getData(string: totalSquares[indexPath.row])
        //cell.dayOfMonth.textColor = .black
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let monthYear = dateFormatter.string(from: selectedDate)
        let day = totalSquares[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        if day != "" {
            let dayString = day.count < 2 ? "0\(day)" : day
            let date = "\(monthYear)-\(dayString)"
            print(date)
            cell.backgroundColor = .white
//            cell.dayOfMonth.textColor = .black
            if totalSquares[indexPath.row] == day {
                cell.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
                //cell.dayOfMonth.textColor = .white
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
}

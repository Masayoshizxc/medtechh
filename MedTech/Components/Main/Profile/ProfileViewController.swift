//
//  ProfileViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: ProfileViewModelProtocol
    
    let tableView = UITableView()
    
    let shape = CAShapeLayer()
    
    init(vm: ProfileViewModelProtocol = ProfileViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.to.line.alt"), for: .normal)
        button.setTitle(" Выйти", for: .normal)
        button.setTitleColor(UIColor(named: "Violet"), for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "LightestPeach")
        button.layer.cornerRadius = 20
        button.tintColor = UIColor(named: "Violet")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var editButton : UIButton = {
        let button = UIButton()
        button.setTitle("Изменить", for: .normal)
        button.addTarget(self, action: #selector(goToVC2), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var sosButton : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Peach")
        return button
    }()
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.frame.size = CGSize(width: 75, height: 75)
        imageView.image = Icons.profileImage.image
        imageView.layer.cornerRadius = 37.5
        return imageView
    }()
    let trimestImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.image = UIImage(named: "trimestInfo")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var weekLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(named: "Violet")
        label.text = "14-ая\nнеделя"
        label.frame = CGRect(x: trimestImage.bounds.origin.x,
                             y: trimestImage.bounds.origin.y,
                             width: 300, height: 45)
        label.textAlignment = .center
        self.trimestImage.addSubview(label)
        return label
    }()
    
    private lazy var trimestLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(named: "Violet")
        label.text = "2-й\nтриместр"
        label.frame = CGRect(x: trimestImage.bounds.origin.x, y: trimestImage.bounds.origin.y, width: 300, height: 45)
        label.textAlignment = .center
        self.trimestImage.addSubview(label)
        return label
    }()
    let downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Скачать медкарту", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.titleLabel?.contentMode = .left
        button.setTitleColor(UIColor(named: "Violet"), for: .normal)
        return button
    }()
    
    let viewInView : UIView = {
        let view = UIView()
        return view
    }()
    
    let userName : UILabel = {
        let name = UILabel()
        name.text = "Айжамал Масыбаева Бекболсуновна"
        name.font = .boldSystemFont(ofSize: 25)
        name.textColor = UIColor(named: "Violet")
        name.numberOfLines = 0
        return name
    }()
    
    lazy var dataView : UIView = {
        let vieww = UIView()
        return vieww
        
    }()
    let box : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    let viewAsTableView : UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 336, height: 270)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let doctorTitle : UILabel = {
        let label = UILabel()
        label.text = "Гинеколог"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let doctorName : UILabel = {
        let label = UILabel()
        label.text = "Хафизова Валентина Владимировна"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let mailTitle : UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let mailName : UILabel = {
        let label = UILabel()
        label.text = "aizhamal@gmail.com"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    let numberTitle : UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let numberName : UILabel = {
        let label = UILabel()
        label.text = "+996551552770"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    let bDayTitle : UILabel = {
        let label = UILabel()
        label.text = "Дата рождения"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let bDayName : UILabel = {
        let label = UILabel()
        label.text = "28.09.2002"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    let addressTitle : UILabel = {
        let label = UILabel()
        label.text = "Место проживания"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let addressName : UILabel = {
        let label = UILabel()
        label.text = "Ул. Юнусалиева 81"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(named: "Violet")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        view.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        addProgressBar()
        getPatient()
        
        setUpSubviews()
        setUpScrollView()
        setUpConstraints()
        
    }
    
    func addProgressBar() {
        let circlePath = UIBezierPath(arcCenter: profileImage.center,
                                      radius: 45,
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.strokeColor = UIColor(named: "LightestPeach")?.cgColor
        trackShape.lineWidth = 2
        profileImage.layer.addSublayer(trackShape)
        
        let shape = CAShapeLayer()
        shape.path = circlePath.cgPath
        shape.lineWidth = 2
        shape.strokeColor = UIColor(named: "Peach")?.cgColor
        shape.strokeEnd = 0.4
        shape.fillColor = UIColor.clear.cgColor
        
        profileImage.layer.addSublayer(shape)
    }
    
    func setUpSubviews(){
        view.addSubviews(scrollView, sosButton)
        scrollView.addSubview(dataView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton)
        dataView.addSubviews(
            profileImage,
            trimestImage,
            downloadButton,
            userName,
            viewAsTableView,
            viewInView,
            logOutButton,
            editButton)
        viewAsTableView.addSubview(box)
        trimestImage.addSubviews(weekLabel,trimestLabel)
        viewInView.addSubviews(doctorTitle,mailTitle,numberTitle,bDayTitle,addressTitle ,doctorName,mailName,numberName,bDayName,addressName)
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
    
    func getPatient() {
        let userId = userDefaults.getUserId()
        viewModel.getPatient(id: userId) { result in
            print(result)
            let user = result?.userDTO
            let doctor = result?.doctorDTO?.userDTO
            self.userName.text = "\(user!.firstName) \(user!.lastName) \(user!.middleName)"
            self.doctorName.text = "\(doctor!.firstName) \(doctor!.lastName) \(doctor!.middleName)"
            self.mailName.text = user?.email
            self.numberName.text = user?.phoneNumber
            self.bDayName.text = user?.dob
            self.addressName.text = user?.address
            //self.profileImage.sd_setImage(with: us)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startOfPregancy = dateFormatter.date(from: (result?.startOfPregnancy)!)
            let dateRangeStart = Date()
            let components = Calendar.current.dateComponents([.weekOfYear], from: startOfPregancy!, to: dateRangeStart)
            let weeks = components.weekOfYear ?? 0
            self.weekLabel.text = "\(weeks)-я\n неделя"
            if weeks <= 12 {
                self.trimestLabel.text = "1-й\nтриместр"
            } else if weeks > 12 && weeks <= 27 {
                self.trimestLabel.text = "2-й\nтриместр"
            } else if weeks > 27 && weeks <= 40{
                self.trimestLabel.text = "3-й\nтриместр"
            } else {
                self.trimestLabel.text = "Ваша беременность закончилась"
            }
        }
    }
    
    @objc func didTapLogOutButton() {
        userDefaults.isSignedIn(signedIn: false)
        let userId = userDefaults.getUserId()
        let data: [String : Any] = [
            "userId" : userId
        ]
        let encodedData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let sheet = UIAlertController(title: "Выйти", message: "Вы уверены что вы хотите выйти из аккаунта?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.viewModel.logOut(data: encodedData!) { result in
                let vc = LoginViewController()
                self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            }
            
        }))
        present(sheet, animated: true)
        
    }
    
    @objc func goToVC2() {
        let loadVC = EditProfileViewController()
        tabBarController?.navigationController?.pushViewController(loadVC, animated: true)
    }
    
    func setUpScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.width, height: 700 + 200)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //    func setUpTableViewController(){
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "cell")
    //    }
    
    func setUpConstraints() {
        logOutButton.snp.makeConstraints { make in
            //            make.left.equalToSuperview().inset(235)
            //            make.right.equalToSuperview().inset(27)
            make.top.equalTo(editButton.snp.bottom).offset(65)
            make.width.equalTo(128)
            make.height.equalTo(44)
            logOutButton.snp.makeConstraints { make in
    //            make.left.equalToSuperview().inset(235)
    //            make.right.equalToSuperview().inset(27)
                make.top.equalTo(editButton.snp.bottom).offset(32)
                make.width.equalTo(128)
                make.height.equalTo(44)
                
    //            make.top.equalTo(dataView.snp.bottom).inset(94)
                make.left.right.equalToSuperview().inset(27)
            }
            
//            editButton.snp.makeConstraints{make in
//    //            make.top.equalToSuperview().inset(65)
//    //            make.left.equalToSuperview().inset(30)
//    //            make.width.equalTo(65)
//    //            make.height.equalTo(44)
//
//            }
            sosButton.snp.makeConstraints{make in
                make.top.equalToSuperview().inset(65)
                make.right.equalToSuperview().inset(30)
                make.width.equalTo(65)
                make.height.equalTo(44)
            }
//            titleForPage.snp.makeConstraints{make in
//                make.top.equalToSuperview().inset(70)
//                make.centerX.equalToSuperview()
//            }
            profileImage.snp.makeConstraints{make in
                make.top.equalToSuperview().inset(40)
                make.left.equalToSuperview().inset(37)
                make.width.height.equalTo(75)
            }
            trimestImage.snp.makeConstraints{make in
                make.top.equalTo(profileImage.snp.bottom).offset(27)
    //            make.centerX.equalToSuperview()
//                make.centerX.equalToSuperview()
                make.left.right.equalToSuperview().inset(27)
                make.height.equalTo(120)
            }
            weekLabel.snp.makeConstraints{make in
                make.centerY.equalTo(trimestImage)
                make.left.equalToSuperview().inset(40)
            }
            trimestLabel.snp.makeConstraints{make in
                make.centerY.equalTo(trimestImage)
                make.right.equalToSuperview().inset(40)
            }
            downloadButton.snp.makeConstraints{make in
                make.top.equalTo(trimestImage.snp.bottom).offset(30)
                make.left.right.equalToSuperview().inset(27)
    //            make.width.equalTo(336)
                make.height.equalTo(60)
            }
            
            viewInView.snp.makeConstraints{make in
                make.top.equalTo(downloadButton.snp.bottom).offset(30)
                make.left.right.equalToSuperview().inset(27)
    //            make.width.equalTo(336)
                make.height.equalTo(300)
            }

            //            make.top.equalTo(dataView.snp.bottom).inset(94)
            make.left.right.equalToSuperview().inset(27)
        }
        
        //            editButton.snp.makeConstraints{make in
        //    //            make.top.equalToSuperview().inset(65)
        //    //            make.left.equalToSuperview().inset(30)
        //    //            make.width.equalTo(65)
        //    //            make.height.equalTo(44)
        //
        //            }
        sosButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        //            titleForPage.snp.makeConstraints{make in
        //                make.top.equalToSuperview().inset(70)
        //                make.centerX.equalToSuperview()
        //            }
        profileImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().inset(35)
            make.width.height.equalTo(75)
        }
        trimestImage.snp.makeConstraints{make in
            make.top.equalTo(profileImage.snp.bottom).offset(27)
            //            make.centerX.equalToSuperview()
            //                make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(120)
        }
        weekLabel.snp.makeConstraints{make in
            make.centerY.equalTo(trimestImage)
            make.left.equalToSuperview().inset(40)
        }
        trimestLabel.snp.makeConstraints{make in
            make.centerY.equalTo(trimestImage)
            make.right.equalToSuperview().inset(40)
        }
        downloadButton.snp.makeConstraints{make in
            make.top.equalTo(trimestImage.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(27)
            //            make.width.equalTo(336)
            make.height.equalTo(60)
        }
        
        viewInView.snp.makeConstraints{make in
            make.top.equalTo(downloadButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(27)
            //            make.width.equalTo(336)
            make.height.equalTo(300)
        }

        editButton.snp.makeConstraints{make in
            make.top.equalTo(viewInView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(44)
        }
        userName.snp.makeConstraints{make in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(30)
            make.width.equalTo(230)
        }
        dataView.snp.makeConstraints{make in
            //                make.top.left.right.bottom.equalToSuperview()
            //                make.top.equalToSuperview()
            make.width.equalTo(view.frame.size.width)
            make.height.equalTo(700 + 200)
            

            scrollView.snp.makeConstraints{make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(view.frame.size.height - 100)
    //            make.left.right.equalToSuperview().inset(27)
                
            }
    //        tableView.snp.makeConstraints{make in
    //            make.top.bottom.left.right.equalToSuperview()
    //        }
    //        appointTable.tableView.snp.makeConstraints{make in
    //            make.top.bottom.left.right.equalToSuperview()
    //        }
            doctorTitle.snp.makeConstraints{make in
                make.top.equalToSuperview().inset(8)
                make.left.equalToSuperview()
            }
            mailTitle.snp.makeConstraints{make in
                make.top.equalTo(doctorTitle.snp.bottom).offset(31)
                make.left.equalToSuperview()
            }
            numberTitle.snp.makeConstraints{make in
                make.top.equalTo(mailTitle.snp.bottom).offset(31)
                make.left.equalToSuperview()
            }
            bDayTitle.snp.makeConstraints{make in
                make.top.equalTo(numberTitle.snp.bottom).offset(31)
                make.left.equalToSuperview()
            }
            addressTitle.snp.makeConstraints{make in
                make.top.equalTo(bDayTitle.snp.bottom).offset(31)
                make.left.equalToSuperview()
            }
//            passwordTitle.snp.makeConstraints{make in
//                make.top.equalTo(addressTitle.snp.bottom).offset(31)
//                make.left.equalToSuperview()
//            }
            doctorName.snp.makeConstraints{make in
                make.top.equalToSuperview().inset(8)
                make.right.equalToSuperview()
            }
            mailName.snp.makeConstraints{make in
                make.top.equalTo(doctorName.snp.bottom).offset(31)
                make.right.equalToSuperview()
            }
            numberName.snp.makeConstraints{make in
                make.top.equalTo(mailName.snp.bottom).offset(31)
                make.right.equalToSuperview()
            }
            bDayName.snp.makeConstraints{make in
                make.top.equalTo(numberName.snp.bottom).offset(31)
                make.right.equalToSuperview()
            }
            addressName.snp.makeConstraints{make in
                make.top.equalTo(bDayName.snp.bottom).offset(31)
                make.right.equalToSuperview()
            }
//            passwordName.snp.makeConstraints{make in
//                make.top.equalTo(addressName.snp.bottom).offset(31)
//                make.right.equalToSuperview()
//            }
//

            
        }
        viewAsTableView.snp.makeConstraints{make in
            //            make.top.equalTo(downloadButton.snp.bottom).offset(30)
            //            make.left.equalToSuperview()
            make.top.equalTo(downloadButton.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        box.snp.makeConstraints{make in
            make.centerX.centerY.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{make in
            make.top.equalTo(sosButton.snp.bottom).offset(60)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview()
            //            make.left.right.equalToSuperview().inset(27)
            
        }
        
        //        tableView.snp.makeConstraints{make in
        //            make.top.bottom.left.right.equalToSuperview()
        //        }
        //        appointTable.tableView.snp.makeConstraints{make in
        //            make.top.bottom.left.right.equalToSuperview()
        //        }
        doctorTitle.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview()

        }
        mailTitle.snp.makeConstraints{make in
            make.top.equalTo(doctorTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        numberTitle.snp.makeConstraints{make in
            make.top.equalTo(mailTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        bDayTitle.snp.makeConstraints{make in
            make.top.equalTo(numberTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        addressTitle.snp.makeConstraints{make in
            make.top.equalTo(bDayTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        //            passwordTitle.snp.makeConstraints{make in
        //                make.top.equalTo(addressTitle.snp.bottom).offset(31)
        //                make.left.equalToSuperview()
        //            }
        doctorName.snp.makeConstraints{make in
            make.top.equalTo(doctorTitle.snp.top)
            make.right.equalToSuperview()
        }
        mailName.snp.makeConstraints{make in
            make.top.equalTo(doctorName.snp.bottom).offset(31)
            make.right.equalToSuperview()
        }
        numberName.snp.makeConstraints{make in
            make.top.equalTo(mailName.snp.bottom).offset(31)
            make.right.equalToSuperview()
        }
        bDayName.snp.makeConstraints{make in
            make.top.equalTo(numberName.snp.bottom).offset(31)
            make.right.equalToSuperview()
        }
        addressName.snp.makeConstraints{make in
            make.top.equalTo(bDayName.snp.bottom).offset(31)
            make.right.equalToSuperview()
        }
        //            passwordName.snp.makeConstraints{make in
        //                make.top.equalTo(addressName.snp.bottom).offset(31)
        //                make.right.equalToSuperview()
        //            }
        
    }
    
}


extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        if(indexPath.row == 0){
            cell.textLabel?.text = "Лечащий врач"
            cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            cell.textLabel?.textColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
            cell.textLabel?.textAlignment = .center
            return cell
        }
        if(indexPath.row == 1){
            cell.imageView?.image = UIImage(named: "doctorPhoto")
            cell.imageView?.layer.cornerRadius = cell.imageView?.frame.size.width ?? 50 / 2
            cell.textLabel?.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
            cell.textLabel?.text = " Хафизова  Валентина    Владимировна"
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        if(indexPath.row == 0 || indexPath.row == 1){
            cell.layer.borderWidth = 10
            cell.layer.borderColor = UIColor.yellow.cgColor
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 50
        }
        if(indexPath.row == 1){
            return 70
        }
        else{
            return CGFloat(50)
        }
    }
}

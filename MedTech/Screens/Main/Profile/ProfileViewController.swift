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
        button.setTitleColor(UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 248/255, green: 229/255, blue: 229/255, alpha: 1)
        button.layer.cornerRadius = 20
//        button.setTitleColor(UIColor(red: 248/255, green: 229/255, blue: 229/255, alpha: 1), for: .normal)
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleForPage : UILabel = {
        var title = UILabel()
        title.text = "Профиль"
        title.textColor = .black
//        title.font = title.font.withSize(25)
        title.font = .boldSystemFont(ofSize: 25)
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    
//    let notificationsButton : UIButton = {
//       let button = UIButton()
//        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
//
//        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
//        return button
//    }()
    
    let sosButton : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        return button
    }()
    
    let profileImage : UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.frame.size = CGSize(width: 75, height: 75)
        imageView.image = UIImage(named: "profileImage")
        imageView.layer.cornerRadius = 37.5
        imageView.layer.borderColor = UIColor(red: 252/255, green: 208/255, blue: 207/255, alpha: 1).cgColor
        imageView.layer.borderWidth = 1.5
        
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
//    let weekTrimest : UIButton = {
//        let week = UIButton()
//        week.frame.size = CGSize(width: 104, height: 60)
//        week.backgroundColor = UIColor(red: 252/255, green: 208/255, blue: 207/255, alpha: 1)
//        week.setTitle("14-я неделя", for: .normal)
//        week.setTitleColor(.white, for: .normal)
//        week.layer.cornerRadius = 20
//        return week
//    }()
    let trimestLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        label.text = "14-ая неделя"
        
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
        button.setTitleColor(UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1), for: .normal)
//        button.titleLabel?.textColor = UIColor(red: 252/255, green: 208/255, blue: 207/255, alpha: 1)
        return button
    }()
    
    let userName : UILabel = {
       let name = UILabel()
        name.text = "Айжамал Масыбаева Бекболсуновна"
        name.font = .boldSystemFont(ofSize: 25)
        name.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        name.numberOfLines = 0
        return name
    }()
    
    let dataView : UIView = {
       let vieww = UIView()
        vieww.frame.size = CGSize(width: 300, height: 200)
        
        return vieww
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setUpTableViewController()
        setUpSubviews()
//        setUpDataTableView()
        setUpConstraints()
        
    }
    func setUpSubviews(){
        view.addSubviews(logOutButton,
                         //notificationsButton,
                         sosButton,
                         titleForPage,
                         profileImage,
                         logOutButton,
                         trimestImage,
                         downloadButton,
                         userName,
                         dataView)
        trimestImage.addSubview(trimestLabel)
    }
    
   
//    func setUpDataTableView(){
//        dataView.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.isScrollEnabled = false
////        tableView.allowsSelection = false
//
//    }
    @objc func didTapLogOutButton() {
        userDefaults.isSignedIn(signedIn: false)
        let userId = userDefaults.getUserId()
        let data: [String : Any] = [
            "userId" : userId
        ]
        let encodedData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        viewModel.logOut(data: encodedData!) { result in
            print(result!)
        }
        let vc = LoginViewController()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private let appointTable = AppointmentTableViewController()
    func setUpTableViewController(){
        dataView.addSubview(appointTable.tableView)
        
    }
    
    func setUpConstraints() {
        logOutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(235)
            make.right.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(714)
            make.width.equalTo(128)
            make.height.equalTo(44)
        }
        
//        notificationsButton.snp.makeConstraints{make in
//            make.top.equalToSuperview().inset(65)
//            make.left.equalToSuperview().inset(30)
//            make.width.height.equalTo(30)
//        }

        sosButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        titleForPage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
        }
        profileImage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(147)
            make.left.equalToSuperview().inset(37)
            //            make.width.height.equalTo(75)
        }
        trimestImage.snp.makeConstraints{make in
            make.top.equalTo(profileImage).inset(106)
            make.right.left.equalToSuperview().inset(27)
            make.width.equalTo(336)
            make.height.equalTo(120)
        }
        downloadButton.snp.makeConstraints{make in
            make.top.equalTo(trimestImage).inset(150)
            make.left.right.equalToSuperview().inset(27)
            make.width.equalTo(336)
            make.height.equalTo(60)
        }
        userName.snp.makeConstraints{make in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage).inset(profileImage.frame.size.width + 31)
            make.width.equalTo(230)
        }
        dataView.snp.makeConstraints{make in
            make.top.equalTo(downloadButton).inset(90)
            make.width.equalTo(view.frame.size.width - 54)
            make.left.right.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(240)
            
        }
//        tableView.snp.makeConstraints{make in
//            make.top.bottom.left.right.equalToSuperview()
//        }
        appointTable.tableView.snp.makeConstraints{make in
            make.top.bottom.left.right.equalToSuperview()
        }
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

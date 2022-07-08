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

    init(vm: ProfileViewModelProtocol = ProfileViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogOut", for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleForPage4 : UILabel = {
        var title = UILabel()
        title.text = "Профиль"
        title.textColor = .black
//        title.font = title.font.withSize(25)
        title.font = .boldSystemFont(ofSize: 25)
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    
    let notificationsButton4 : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
        
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return button
    }()
    
    let sosButton4 : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
//        button.setTitleShadowColor(.black, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 16
        
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
    
    let weekTrimest : UIButton = {
        let week = UIButton()
        week.frame.size = CGSize(width: 104, height: 60)
        week.backgroundColor = UIColor(red: 252/255, green: 208/255, blue: 207/255, alpha: 1)
        week.setTitle("14-я неделя", for: .normal)
        week.setTitleColor(.white, for: .normal)
        week.layer.cornerRadius = 20
        return week
    }()
    
    let downloadButton : UIButton = {
       let button = UIButton()
        button.frame.size = CGSize(width: 80, height: 60)
        button.setTitle("Медкарта", for: .normal)
        button.backgroundColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 12)
        return button
    }()
    
    let userName : UILabel = {
       let name = UILabel()
        name.text = "Айжамал Масыбаева"
        name.font = .boldSystemFont(ofSize: 25)
        name.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return name
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSubviews()
        setUpConstraints()
    }
    func setUpSubviews(){
        view.addSubviews(notificationsButton4,
                         sosButton4,
                         titleForPage4,
                         profileImage,
                         logOutButton,
                         weekTrimest,
                         downloadButton,
                         userName)
    }
    
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
    
    func setUpConstraints() {
        logOutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(400)
            make.width.equalTo(120)
            make.height.equalTo(60)
        }
        
        notificationsButton4.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }

        sosButton4.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        titleForPage4.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
        }
        profileImage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(147)
            make.left.equalToSuperview().inset(37)
            //            make.width.height.equalTo(75)
        }
        weekTrimest.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(155)
            make.left.equalToSuperview().inset(147)
            make.width.equalTo(104)
            make.height.equalTo(60)
        }
        downloadButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(155)
            make.left.equalToSuperview().inset(281)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        userName.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(240)
            make.left.equalToSuperview().inset(27)
            
        }
    }
}

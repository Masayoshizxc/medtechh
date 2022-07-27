//
//  EditProfileViewController.swift
//  MedTech
//
//  Created by Adilet on 15/7/22.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController {
    
    private lazy var goToVC1 : UIButton = {
        let button = UIButton()
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.red.cgColor
//        button.setTitle("< Back", for: .normal)
//        button.backgroundColor = .yellow
//        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(goToProfilePage), for: .touchUpInside)
        return button
    }()
    let titleForPage : UILabel = {
        let label = UILabel()
        label.text = "Изменить профиль"
        label.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    private lazy var saveButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "done"), for: .normal)

        return button
    }()
    let profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 37.5
        image.image = UIImage(named: "profileImage")
        return image
    }()
    private lazy var changeImageButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        return button
    }()
    
    let placeUserName : UILabel = {
        let label = UILabel()
        label.text = "ФИО"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let placeUserMail : UILabel = {
        let label = UILabel()
        label.text = "Электронная почта"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let placeUserNumber : UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let placeUserBirth : UILabel = {
        let label = UILabel()
        label.text = "Дата рождения"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let placeUserAddress : UILabel = {
        let label = UILabel()
        label.text = "Место проживания"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let placeUserPassword : UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()
    let userName : UILabel = {
        let label = UILabel()
        label.text = "Масыбаева Айжамал Айдаровна"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userMail : UILabel = {
        let label = UILabel()
        label.text = "aizhamal@gmail.com"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userNumber : UITextField = {
        let label = UITextField()
        label.text = "+996551552770"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userBirth : UILabel = {
        let label = UILabel()
        label.text = "28.09.1999"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userAddress : UITextField = {
        let label = UITextField()
        label.text = "Ул. Юнусалиева 81"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userPassword : UITextField = {
        let label = UITextField()
        label.text = "1********9"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(goToVC1,
                         titleForPage,
                         saveButton,
                         profileImage,
                         changeImageButton,
                         placeUserName,
                         placeUserMail,
                         placeUserNumber,
                         placeUserBirth,
                         placeUserAddress,
                         placeUserPassword,
                         userName,
                         userMail,
                         userNumber,
                         userBirth,
                         userAddress,
                         userPassword)
        view.backgroundColor = .white
        setUpConstraints()
    }
    
    @objc func goToProfilePage(){
        dismiss(animated: true, completion: nil)
    }
    func setUpConstraints() {
        
//        goToVC1.snp.makeConstraints{make in
////            make.top.equalToSuperview().inset(20)
////            make.left.equalToSuperview().inset(20)
////            make.center.equalToSuperview()
////            make.width.height.equalTo(100)
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        goToVC1.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(71)
            make.left.equalToSuperview().inset(27)
            make.width.height.equalTo(24)
        }
        titleForPage.snp.makeConstraints{make in
            make.centerY.equalTo(goToVC1)
//            make.left.equalTo(goToVC1.snp.right).inset(52)
            make.centerX.equalToSuperview()
        }
        saveButton.snp.makeConstraints{make in
            make.centerY.equalTo(titleForPage)
            make.right.equalToSuperview().inset(27)
            make.width.height.equalTo(24)
        }
        profileImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleForPage.snp.bottom).offset(36)
            make.width.height.equalTo(90)
            
        }
        changeImageButton.snp.makeConstraints{make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.width.height.equalTo(20)
            make.left.equalTo(profileImage.snp.left).inset(62)
        }
        placeUserName.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(profileImage.snp.bottom).offset(32)
            
        }
        userName.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserName.snp.bottom).offset(16)
        }
        placeUserMail.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userName.snp.bottom).offset(27)
            
        }
        userMail.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserMail.snp.bottom).offset(16)
        }
        placeUserNumber.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userMail.snp.bottom).offset(27)
            
        }
        userNumber.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserNumber.snp.bottom).offset(16)
        }
        placeUserBirth.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userNumber.snp.bottom).offset(27)
            
        }
        userBirth.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserBirth.snp.bottom).offset(16)
        }
        placeUserAddress.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userBirth.snp.bottom).offset(27)
            
        }
        userAddress.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserAddress.snp.bottom).offset(16)
        }
        placeUserPassword.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userAddress.snp.bottom).offset(27)
            
        }
        userPassword.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserPassword.snp.bottom).offset(16)
        }
    }
}

extension UILabel {
    func didSet() {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
        }
}

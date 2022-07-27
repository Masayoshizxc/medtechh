//
//  EditProfileViewController.swift
//  MedTech
//
//  Created by Adilet on 15/7/22.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController {

    private lazy var saveButton : UIButton = {
        let button = UIButton()
        button.setImage(Icons.done.image, for: .normal)
        return button
    }()
    let profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 37.5
        image.image = Icons.profileImage.image
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
    lazy var userNumber : UITextField = {
        let label = UITextField()
        label.text = "+996551552770"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        label.keyboardType = .namePhonePad
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 25, width: view.frame.size.width - 60, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    let userBirth : UILabel = {
        let label = UILabel()
        label.text = "28.09.1999"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    lazy var userAddress : UITextField = {
        let label = UITextField()
        label.text = "Ул. Юнусалиева 81"
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 25, width: view.frame.size.width - 60, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изменить профиль"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(named: "Violet")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(named: "Violet")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        view.addSubviews(
            profileImage,
            changeImageButton,
            placeUserName,
            placeUserMail,
            placeUserNumber,
            placeUserBirth,
            placeUserAddress,
            userName,
            userMail,
            userNumber,
            userBirth,
            userAddress
        )
        view.backgroundColor = .white
        setUpConstraints()
    }
    
    func setUpConstraints() {

        profileImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
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

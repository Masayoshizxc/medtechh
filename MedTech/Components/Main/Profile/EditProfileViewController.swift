//
//  EditProfileViewController.swift
//  MedTech
//
//  Created by Adilet on 15/7/22.
//

import UIKit
import SnapKit

class EditProfileViewController: BaseViewController {
    
    var model: Patient?
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: ProfileViewModelProtocol
    
    init(vm: ProfileViewModelProtocol = ProfileViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var saveButton : UIButton = {
        let button = UIButton()
        button.setImage(Icons.done.image, for: .normal)
        button.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        return button
    }()
    let profileImage : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 45
        image.image = Icons.profileImage.image
        return image
    }()
    private lazy var changeImageButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapPencil), for: .touchUpInside)
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
    
    private lazy var confirmButton: LoginButton = {
        let button = LoginButton()
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        button.setTitle("Confirm", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изменить профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        let user = model?.userDTO
        userName.text = "\(user!.lastName) \(user!.firstName) \(user!.middleName)"
        userMail.text = user!.email
        userNumber.text = user!.phoneNumber
        userBirth.text = user!.dob
        userAddress.text = user!.address
        let imageURL = model?.imageUrl!.replacingOccurrences(of: "http://localhost:8080", with: "https://medtech-team5.herokuapp.com")
        guard let image = URL(string: imageURL!) else {
            print("There is no image")
            return
        }
        self.profileImage.sd_setImage(with: image)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
            userAddress,
            confirmButton
        )
        setUpConstraints()
    }
    @objc func didTapDone() {
        let vc = PasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapPencil() {
        presentPhotoActionSheet()
    }
    
    @objc func didTapConfirmButton() {
        guard let address = userAddress.text, let number = userNumber.text else {
            return
        }
        let userId = userDefaults.getUserId()
        let imageData = profileImage.image
        viewModel.getAddressAndPhone(id: userId, address: address, phone: number) { result in
            print(result)
            DispatchQueue.main.async {
                self.userAddress.text = result?.userDTO?.address
                self.userNumber.text = result?.userDTO?.phoneNumber
            }
        }
        let data = profileImage.image!.jpegData(compressionQuality: 0.5)
        if model?.imageUrl != nil {
            viewModel.changeImage(id: userId, image: data!) { result in
                print("This is modeflsefkejf", result)
            }
        } else {
            viewModel.addImage(id: userId, image: data!) { result in
                print(result)
            }
        }
        
        
        
        
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
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userAddress.snp.bottom).offset(40)
            make.width.equalTo(336)
            make.height.equalTo(50)
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose a photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        profileImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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

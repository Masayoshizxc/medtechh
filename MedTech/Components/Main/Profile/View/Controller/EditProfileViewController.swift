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
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    let userMail : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    lazy var userNumber : UITextField = {
        let label = UITextField()
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        label.keyboardType = .phonePad
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 25, width: view.frame.size.width - 60, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    let userBirth : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        return label
    }()
    lazy var userAddress : UITextField = {
        let label = UITextField()
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 25, width: view.frame.size.width - 60, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    private lazy var editButton : UIButton = {
        let button = UIButton()
        button.setTitle("Изменить пароль", for: .normal)
        button.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var confirmButton: LoginButton = {
        let button = LoginButton()
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        button.setTitle("Подтвердить", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изменить профиль"
        
        setUpData()
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
            editButton,
            confirmButton
        )
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Изменить профиль"
        navigationItem.hidesBackButton = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
        navigationItem.hidesBackButton = true
    }
    
    func setUpData() {
        let user = model?.userDTO
        userName.text = "\(user?.lastName ?? "") \(user?.firstName ?? "") \(user?.middleName ?? "")"
        userMail.text = user?.email
        userNumber.text = user?.phoneNumber
        guard let dob = user?.dob else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateDate = dateFormatter.date(from: dob)
        dateFormatter.dateFormat = "d MMMM yyyy"
        let dateStr = dateFormatter.string(from: dateDate!)
        userBirth.text = dateStr
        userAddress.text = user?.address
        guard let imageUrl = model?.imageUrl else {
            return
        }
        guard let image = URL(string: imageUrl) else {
            print("There is no image")
            return
        }
        self.profileImage.sd_setImage(with: image)
    }
    
    @objc func didTapChangePassword() {
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
        guard address != model?.userDTO?.address || number != model?.userDTO?.phoneNumber else {
            return
        }
        let sheet = UIAlertController(title: "Успешно", message: "Поля успешно изменены.", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
        }))
        viewModel.getAddressAndPhone(address: address, phone: number) { result in
            switch result {
            case .success:
                print("Address and phone changed succesfully!!!")
                self.present(sheet, animated: true)
            case .failure:
                print("There was an error with changing")
            default:
                break
            }
        }
        
        if model?.imageUrl != nil {
            uploadImage(paramName: "image", fileName: "image.png", image: profileImage.image!)
        } else {
        }
    }
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "https://medtech-team5.herokuapp.com/api/v1/patients/img/3")
                
        let session = URLSession.shared
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        //urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; fileName=\"\(fileName)\"\r\n".data(using: .utf8)!)
        //data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            } else {
                print(error as Any)
            }
        }).resume()
        
    }
    
    func setUpConstraints() {
        
        profileImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(120)
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
        
        placeUserBirth.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userMail.snp.bottom).offset(27)
        }
        userBirth.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(placeUserBirth.snp.bottom).offset(16)
        }
        
        placeUserNumber.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userBirth.snp.bottom).offset(27)
            
        }
        userNumber.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(27)
            make.top.equalTo(placeUserNumber.snp.bottom).offset(16)
        }
        
        placeUserAddress.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalTo(userNumber.snp.bottom).offset(27)
            
        }
        userAddress.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(27)
            make.top.equalTo(placeUserAddress.snp.bottom).offset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(userAddress.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(44)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(45)
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

//
//  ProfileViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
        
    let tableView = UITableView()
    let shape = CAShapeLayer()
    
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
        button.setImage(Icons.logout.image, for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "LightestPeach")
        button.layer.cornerRadius = 16
        button.tintColor = UIColor(named: "Violet")
        button.frame = CGRect(x: 0, y: 0, width: 56, height: 44)
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
        imageView.layer.masksToBounds = false
        imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        //imageView.layer.cornerRadius = 37.5
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
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        return scrollView
    }()
    
    private lazy var weekLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(named: "Violet")
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
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(named: "Violet")
        label.frame = CGRect(x: trimestImage.bounds.origin.x, y: trimestImage.bounds.origin.y, width: 300, height: 45)
        label.textAlignment = .center
        self.trimestImage.addSubview(label)
        return label
    }()
    lazy var downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Скачать медкарту", for: .normal)
        button.setTitleColor(UIColor(named: "Violet"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "LightPeach")?.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.download.image
        return imageView
    }()
    
    let viewInView : UIView = {
        let view = UIView()
        return view
    }()
    
    let userName : UILabel = {
        let name = UILabel()
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
    lazy var doctorTitle : UILabel = {
        let label = UILabel()
        label.text = "Гинеколог"
        label.textColor = UIColor(named: "Violet")
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 40, width: view.frame.size.width - 32, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    lazy var doctorName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mailTitle : UILabel = {
        let label = UILabel()
        label.text = "Почта"
        label.textColor = UIColor(named: "Violet")
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 35, width: view.frame.size.width - 32, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    let mailName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    lazy var numberTitle : UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.textColor = UIColor(named: "Violet")
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 35, width: view.frame.size.width - 32, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    let numberName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    lazy var bDayTitle : UILabel = {
        let label = UILabel()
        label.text = "Дата рождения"
        label.textColor = UIColor(named: "Violet")
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 35, width: view.frame.size.width - 32, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        label.layer.addSublayer(bottomBorder)
        return label
    }()
    
    let bDayName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    lazy var addressTitle : UILabel = {
        let label = UILabel()
        label.text = "Место проживания"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    let addressName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        getPatient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logOutButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton)
        scrollView.showsVerticalScrollIndicator = false
        addProgressBar()
        setUpScrollView()
        
        view.addSubviews(scrollView, sosButton)
        scrollView.addSubview(dataView)
        dataView.addSubviews(
            profileImage,
            trimestImage,
            downloadButton,
            userName,
            viewAsTableView,
            viewInView,
            editButton
        )
        downloadButton.addSubview(imageView)
        viewAsTableView.addSubview(box)
        trimestImage.addSubviews(weekLabel,trimestLabel)
        viewInView.addSubviews(doctorTitle,mailTitle,numberTitle,bDayTitle,addressTitle ,doctorName,mailName,numberName,bDayName,addressName)
        setUpConstraints()
        
        view.makeToastActivity(.center)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPatient()
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
        trackShape.lineWidth = 5
        profileImage.layer.addSublayer(trackShape)
            
        shape.path = circlePath.cgPath
        shape.lineWidth = 5
        shape.strokeColor = UIColor(named: "Peach")?.cgColor
        shape.strokeEnd = 0
        shape.fillColor = UIColor.clear.cgColor
        profileImage.layer.addSublayer(shape)
    }
    
    @objc func didTapDownloadButton() {
        view.makeToastActivity(.center)
        let userId = UserDefaultsService.shared.getUserId()
        guard let url = URL(string: "https://medtech-team5.herokuapp.com/api/v1/word/\(userId)") else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    @objc func didPullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getPatient()
            self.scrollView.refreshControl?.endRefreshing()
        }
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
        self.viewModel.getPatient() { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            guard let patient = strongSelf.viewModel.patient else {
                return
            }

            DispatchQueue.main.async {
                let user = patient.userDTO
                let doctor = patient.doctorDTO?.userDTO
                strongSelf.userName.text = "\(user?.firstName ?? "") \(user?.lastName ?? "") \(user?.middleName ?? "")"
                strongSelf.doctorName.text = "\(doctor?.firstName ?? "") \(doctor?.lastName ?? "") \(doctor?.middleName ?? "")"
                strongSelf.mailName.text = user?.email
                strongSelf.numberName.text = user?.phoneNumber

                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ru")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateDate = dateFormatter.date(from: (user?.dob)!)
                dateFormatter.dateFormat = "d MMMM yyyy"
                let dateStr = dateFormatter.string(from: dateDate!)
                strongSelf.bDayName.text = dateStr
                strongSelf.addressName.text = user?.address
            }
            
            guard let startOfPregnancy = patient.startOfPregnancy else {
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startOfPregancy = dateFormatter.date(from: startOfPregnancy)
            let dateRangeStart = Date()
            let components = Calendar.current.dateComponents([.weekOfYear], from: startOfPregancy!, to: dateRangeStart)
            let weeks = components.weekOfYear ?? 0
            
            DispatchQueue.main.async {
                strongSelf.weekLabel.text = "\(weeks)-я\n неделя"
                if weeks <= 12 {
                    strongSelf.trimestLabel.text = "1-й\nтриместр"
                } else if weeks > 12 && weeks <= 27 {
                    strongSelf.trimestLabel.text = "2-й\nтриместр"
                } else if weeks > 27 && weeks <= 41{
                    strongSelf.trimestLabel.text = "3-й\nтриместр"
                } else {
                    strongSelf.trimestLabel.text = "Ваша беременность закончилась"
                }
            }
            
            
            strongSelf.shape.strokeEnd = CGFloat(Double(weeks) / 41.0)
                            
            guard let imageUrl = patient.imageUrl else {
                self?.profileImage.image = Icons.profileImage.image
                strongSelf.view.hideToastActivity()
                return
            }
            guard let image = URL(string: imageUrl) else {
                print("There is no image")
                return
            }
            strongSelf.profileImage.sd_setImage(with: image)
            DispatchQueue.main.async {
                strongSelf.view.hideToastActivity()
            }
        }
    }
    
    @objc func didTapLogOutButton() {
        
        let sheet = UIAlertController(title: "Выйти", message: "Вы уверены что вы хотите выйти из аккаунта?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.viewModel.logOut() { result in
                if result == .success {
                    let vc = LoginViewController()
                    self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
                    UserDefaultsService.shared.isSignedIn(signedIn: false)
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
                
            }
            
        }))
        present(sheet, animated: true)
        
    }
    
    @objc func goToVC2() {
        let loadVC = EditProfileViewController()
        loadVC.model = viewModel.patient
        tabBarController?.navigationController?.pushViewController(loadVC, animated: true)
    }
    
    func setUpScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.width, height: 700 + 200)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        
        sosButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }

        profileImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().inset(35)
            make.width.height.equalTo(75)
        }
        trimestImage.snp.makeConstraints{make in
            make.top.equalTo(profileImage.snp.bottom).offset(27)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        weekLabel.snp.makeConstraints{make in
            make.centerY.equalTo(trimestImage)
            make.left.equalToSuperview().inset(40)
//            make.height.equalTo(58)
//            make.width.equalTo(123)
        }
        trimestLabel.snp.makeConstraints{make in
            make.centerY.equalTo(trimestImage)
            make.right.equalToSuperview().inset(40)
//            make.height.equalTo(58)
//            make.width.equalTo(123)
            
        }
        downloadButton.snp.makeConstraints{make in
            make.top.equalTo(trimestImage.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        viewInView.snp.makeConstraints{make in
            make.top.equalTo(downloadButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }

        editButton.snp.makeConstraints{make in
            make.top.equalTo(viewInView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        userName.snp.makeConstraints{make in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(30)
            make.right.equalToSuperview().inset(16)
        }
        dataView.snp.makeConstraints{make in
            make.width.equalTo(view.frame.size.width)
            make.height.equalTo(700 + 200)
        }
        
        scrollView.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(view.frame.size.height - tabbarHeight)
        }
        
        doctorTitle.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview()
            make.width.equalTo(100)
        }
        
        doctorName.snp.makeConstraints{make in
            make.top.equalTo(doctorTitle.snp.top).offset(-10)
            make.right.equalToSuperview()
            make.left.equalTo(doctorTitle.snp.right).offset(110)
            make.bottom.equalTo(mailTitle.snp.top).offset(-15)
        }
        
        mailTitle.snp.makeConstraints{make in
            make.top.equalTo(doctorTitle.snp.bottom).offset(35)
            make.left.equalToSuperview()
        }
        
        mailName.snp.makeConstraints{make in
            make.centerY.equalTo(mailTitle.snp.centerY)
            make.right.equalToSuperview()
            make.left.equalTo(mailTitle.snp.right).offset(10)
        }
        
        numberTitle.snp.makeConstraints{make in
            make.top.equalTo(mailTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        
        numberName.snp.makeConstraints{make in
            make.top.equalTo(numberTitle.snp.top)
            make.right.equalToSuperview()
            make.left.equalTo(numberTitle.snp.right).offset(10)
        }
        
        bDayTitle.snp.makeConstraints{make in
            make.top.equalTo(numberTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        
        bDayName.snp.makeConstraints{make in
            make.top.equalTo(bDayTitle.snp.top)
            make.right.equalToSuperview()
            make.left.equalTo(bDayTitle.snp.right).offset(10)
        }
        
        addressTitle.snp.makeConstraints{make in
            make.top.equalTo(bDayTitle.snp.bottom).offset(31)
            make.left.equalToSuperview()
        }
        
        addressName.snp.makeConstraints{make in
            make.top.equalTo(addressTitle.snp.top)
            make.right.equalToSuperview()
            make.left.equalTo(addressTitle.snp.right).offset(10)
        }
        
        viewAsTableView.snp.makeConstraints{make in
            make.top.equalTo(downloadButton.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        
        box.snp.makeConstraints{make in
            make.centerX.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(20)
        }
        
    }
    
}

extension ProfileViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let lastUrl = url.appendingPathComponent("Медкарта.docx")
        let docPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationPath = docPath.appendingPathComponent(lastUrl.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationPath)
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationPath)
            let shareSheet = UIActivityViewController(activityItems: [destinationPath], applicationActivities: nil)
            DispatchQueue.main.async {
                self.present(shareSheet, animated: true)
                self.view.hideToastActivity()
            }
        } catch let error {
            self.view.hideToastActivity()
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

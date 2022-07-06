//
//  ProfileViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubviews(
            logOutButton
        )
        setUpConstraints()
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
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(60)
        }
    }
}

//
//  ProfileViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogOut", for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        logOutButton.frame = CGRect(x: 120, y: 320, width: 120, height: 60)
        view.addSubviews(logOutButton)
        
    }
    
    @objc func didTapLogOutButton() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

}

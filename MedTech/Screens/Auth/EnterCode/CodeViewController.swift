//
//  CodeViewController.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import UIKit

class CodeViewController: UIViewController {

    private let codeField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter code"
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.addTarget(self, action: #selector(didTapEnter), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpConstraints()
    }
    
    @objc func didTapEnter() {
        guard let code = codeField.text, !code.isEmpty else {
            print("code is empty")
        }
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpConstraints() {
        codeField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
    }

}


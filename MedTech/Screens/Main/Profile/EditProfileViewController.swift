//
//  EditProfileViewController.swift
//  MedTech
//
//  Created by Adilet on 15/7/22.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController {
    
    let goToVC1 : UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("< Back", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(goToVC1)
        view.backgroundColor = .white
    }
    

    func setUpConstraints() {
        
        goToVC1.snp.makeConstraints{make in
//            make.top.equalToSuperview().inset(20)
//            make.left.equalToSuperview().inset(20)
//            make.center.equalToSuperview()
//            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

//
//  PasswordTextField.swift
//  MedTech
//
//  Created by Eldiiar on 22/6/22.
//

import UIKit

class PasswordTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = Fonts.SFProText.medium.font(size: 16)
        textAlignment = .center
        isSecureTextEntry = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        textColor = .black
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1).cgColor
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

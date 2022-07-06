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
        font = Fonts.Mulish.extraBold.font(size: 16)
        textAlignment = .center
        isSecureTextEntry = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        layer.borderWidth = 1
        layer.borderColor = Colors.yellow.color.cgColor
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

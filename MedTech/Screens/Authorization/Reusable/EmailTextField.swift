//
//  EmailTextField.swift
//  MedTech
//
//  Created by Eldiiar on 22/6/22.
//

import UIKit

class EmailTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        keyboardType = .emailAddress
        autocorrectionType = .no
        font = Fonts.Mulish.extraBold.font(size: 16)
        backgroundColor = UIColor(red: 1, green: 0.982, blue: 0.9, alpha: 0.4)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = Colors.yellow.color.cgColor
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

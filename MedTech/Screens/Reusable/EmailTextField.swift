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
        autocapitalizationType = .none
        font = Fonts.SFProText.medium.font(size: 16)
        textColor = .black
        //backgroundColor = UIColor(red: 1, green: 0.982, blue: 0.9, alpha: 0.4)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1).cgColor
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  CodeTextField.swift
//  MedTech
//
//  Created by Eldiiar on 7/7/22.
//

import UIKit

class CodeTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        keyboardType = .numberPad
        autocorrectionType = .no
        autocapitalizationType = .none
        font = Fonts.SFProText.semibold.font(size: 16)
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1).cgColor
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


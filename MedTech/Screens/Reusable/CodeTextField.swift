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
        font = Fonts.Mulish.extraBold.font(size: 16)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 0.624, green: 0.624, blue: 0.624, alpha: 1).cgColor
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//
//  LoginButton.swift
//  MedTech
//
//  Created by Eldiiar on 22/6/22.
//

import UIKit

class LoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.yellow.color
        layer.cornerRadius = 25
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = Fonts.Mulish.extraBold.font(size: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

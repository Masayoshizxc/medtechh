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
        //backgroundColor = Colors.yellow.color
        backgroundColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        layer.cornerRadius = 15
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = Fonts.SFProText.semibold.font(size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

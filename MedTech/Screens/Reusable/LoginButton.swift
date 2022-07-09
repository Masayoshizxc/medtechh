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
        backgroundColor = UIColor(red: 214/255, green: 122/255, blue: 115/255, alpha: 1)
        layer.cornerRadius = 15
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = Fonts.Mulish.extraBold.font(size: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

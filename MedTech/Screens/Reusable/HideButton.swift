//
//  HideButton.swift
//  MedTech
//
//  Created by Eldiiar on 10/7/22.
//

import UIKit

class HideButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(Icons.hide.image, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

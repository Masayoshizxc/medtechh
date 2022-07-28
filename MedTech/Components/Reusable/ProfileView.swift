//
//  ProfileView.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import UIKit

class ProfileView: UIView {

    private let label1: UILabel = {
        let label = UILabel()
        label.font = Fonts.SFProText.regular.font(size: 14)
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.text =  "Гинеколог"
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.font = Fonts.SFProText.medium.font(size: 14)
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.numberOfLines = 0
        label.text = "Хафизова Валентина Владимировна"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 20.0, y: 63.0, width: frame.height - 10, height: 1.0)
        bottomBorder.backgroundColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1).cgColor
        layer.addSublayer(bottomBorder)
        addSubviews(
          label1,
          label2
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        label1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
        }
        
        label2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(30)
        }
    }
}

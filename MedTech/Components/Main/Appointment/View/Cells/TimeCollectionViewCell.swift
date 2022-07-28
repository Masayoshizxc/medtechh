//
//  TimeCollectionViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 13/7/22.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.text = "11:00"
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(string: String) {
        label.text = string
    }
    
    func changeColor() {
        label.textColor = .white
    }
    
    func changeColorToDefault() {
        label.textColor = UIColor(named: "Violet")
    }
    
    func setUpConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

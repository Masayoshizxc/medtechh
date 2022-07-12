//
//  CalendarCollectionViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 10/7/22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        label.textColor = .black
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
    
    func setUpConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

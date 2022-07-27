//
//  ChecklistTableViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 10/7/22.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.medium.font(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Peach")
        label.font = Fonts.SFProText.medium.font(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(firstLabel, secondLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(model: Checklist) {
        firstLabel.text = model.first
        secondLabel.text = model.second
    }
    
    func setUpConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().dividedBy(1.7)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(firstLabel.snp.right).offset(5)
        }
    }
    
}

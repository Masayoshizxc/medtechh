//
//  ExtraInfoTableViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 15/8/22.
//

import UIKit

class ExtraInfoTableViewCell: UITableViewCell {
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.file.image
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.medium.font(size: 14)
        label.numberOfLines = 0
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(image,
                    label
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(model: String) {
        label.text = model
    }
    
    func setUpConstraints() {

        image.snp.makeConstraints { make in
            make.top.equalTo(label)
            make.left.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(image.snp.right).offset(12)
            make.right.equalToSuperview()
        }
    }
    
}

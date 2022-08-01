//
//  ChecklistCollectionViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit

class ChecklistCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.file.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Fonts.SFProText.medium.font(size: 18)
        label.text = "Обследование"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(imageView, label)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(model: Checklists) {
        imageView.image = model.image
        label.text = model.title
    }

    func setUpConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}

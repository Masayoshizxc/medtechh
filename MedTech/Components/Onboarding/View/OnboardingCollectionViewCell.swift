//
//  OnboardingCollectionViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 12/8/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.semibold.font(size: 24)
        return label
    }()
    
    private let descrp : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.medium.font(size: 16)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            imageView,
            title,
            descrp
        )
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(_ model: Onboarding) {
        imageView.image = model.image
        title.text = model.title
        descrp.text = model.description
    }
    
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(390)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        descrp.snp.makeConstraints { make in
            make.top.equalTo(title)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

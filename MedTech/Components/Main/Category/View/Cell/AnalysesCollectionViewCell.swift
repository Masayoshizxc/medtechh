//
//  AnalysesCollectionViewCell.swift
//  MedTech
//
//  Created by Adilet on 16/8/22.
//

import UIKit
import SnapKit

class AnalysesCollectionViewCell: UICollectionViewCell {
    static let reuseID = "AnalysesCollectionViewCell"
    
    private lazy var analName : UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "Violet")
        l.font = .boldSystemFont(ofSize: 16)
        l.text = "Общий анализ крови"
        return l
    }()
    private lazy var analImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "beakers")
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "LightestPeach")
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(){
        contentView.addSubviews(analName,
                                analImage)
    }
    
    func setUpData(model: Analyzes) {
        analName.text = model.analysisString
    }
    
    
    func setUpConstraints(){
        contentView.layer.cornerRadius = 16
        analName.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(12.5)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(analImage.snp.left).inset(100)
        }
        analImage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(16)
            make.width.height.equalTo(24)
        }
    }
}

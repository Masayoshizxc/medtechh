//
//  DrugCollectionViewCell.swift
//  MedTech
//
//  Created by Adilet on 16/8/22.
//

import UIKit
import SnapKit

class DrugTableViewCell: UITableViewCell {
    
    private lazy var drugImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "domino")
        return img
    }()
    private lazy var drugName : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = UIColor(named: "Violet")
        l.font = .boldSystemFont(ofSize: 16)
        return l
    }()
    
    private lazy var drugDes : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 15)
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "LightestPeach")

        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(){
        contentView.addSubviews(drugImage,
                                drugName,
                                drugDes)
    }
    
    func setUpData(model: Drugs) {
        drugName.text = model.title
        drugDes.text = model.description
    }
    
    
    func setUpConstraints(){
        contentView.layer.cornerRadius = 16
        drugImage.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(16)
            make.width.height.equalTo(36)
            
        }
        drugName.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(12)
            make.left.equalTo(drugImage.snp.right).offset(20)
            make.right.equalToSuperview().inset(16)
        }
        drugDes.snp.makeConstraints{ make in
            make.top.equalTo(drugName.snp.bottom).offset(5)
            make.left.equalTo(drugImage.snp.right).offset(20)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}

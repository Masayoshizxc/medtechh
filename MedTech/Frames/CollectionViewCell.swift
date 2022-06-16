//
//  CollectionViewCell.swift
//  MedTech
//
//  Created by Adilet on 15/6/22.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseID = "CollectionViewCell"
    
    let mainImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50.0/2.0
//        imageView.backgroundColor = UIColor(red: 245/255, green: 233/255, blue: 173/255, alpha: 1)
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let numbersOfWeeks : UILabel = {
        let numbers =  UILabel()
        numbers.font = UIFont(name: "System", size: 35)
//        numbers.text = "1"
        numbers.textColor = .black
        numbers.translatesAutoresizingMaskIntoConstraints = false
        numbers.layer.masksToBounds = true
//        numbers.layer.cornerRadius = 50/2
        numbers.textAlignment = .center
        return numbers
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.addSubview(mainImageView)
//        addSubview(mainImageView)
//        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        addSubview(numbersOfWeeks)
        numbersOfWeeks.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        numbersOfWeeks.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        numbersOfWeeks.topAnchor.constraint(equalTo: topAnchor).isActive = true
        numbersOfWeeks.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        numbersOfWeeks.layer.cornerRadius = 30
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

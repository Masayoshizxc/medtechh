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
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
//        imageView.backgroundColor = UIColor(red: 245/255, green: 233/255, blue: 173/255, alpha: 1)
        imageView.backgroundColor = .white
        return imageView
    }()
    
    
    
    private let numbersOfWeeks : UILabel = {
        let numbers =  UILabel()
        numbers.font = UIFont(name: "System", size: 35)

        numbers.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        numbers.translatesAutoresizingMaskIntoConstraints = false
        numbers.layer.masksToBounds = true

        numbers.textAlignment = .center
        return numbers
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.addSubview(mainImageView)

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
    
    func fill(text: String?) {
        numbersOfWeeks.text = text
    }
}

extension UICollectionReusableView {
    var identifier: String {
        .init(describing: self)
    }
    
    static var identifier: String {
        .init(describing: self)
    }
}

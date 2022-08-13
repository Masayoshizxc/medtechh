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
    let shape = CAShapeLayer()
    
    let mainImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50.0/2.0
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
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
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.mainImageView.layer.borderWidth = 3
                self.mainImageView.layer.borderColor = UIColor(red: 1, green: 0.627, blue: 0.69, alpha: 1).cgColor
            }
            else
            {
                self.mainImageView.layer.borderWidth = 1
                self.mainImageView.layer.borderColor = CGColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setBeforeDate(text: Int) {
        self.mainImageView.layer.borderWidth = 0
        self.mainImageView.layer.borderColor = UIColor.clear.cgColor
        self.mainImageView.backgroundColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1)
        self.numbersOfWeeks.textColor = .white
        numbersOfWeeks.text = String(text)
    }
    
    func fill(text: Int) {
        numbersOfWeeks.text = String(text)
        numbersOfWeeks.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        self.mainImageView.backgroundColor = .white
    }
    
    func addProgressBar(strokeEnd: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: frame.width / 2 - 1,
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        
//        let trackShape = CAShapeLayer()
//        trackShape.path = circlePath.cgPath
//        trackShape.fillColor = UIColor.clear.cgColor
//        trackShape.strokeColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1).cgColor
//        trackShape.lineWidth = 2
//        layer.addSublayer(trackShape)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 2
        shape.strokeColor = UIColor(red: 1, green: 0.714, blue: 0.71, alpha: 1).cgColor
        shape.strokeEnd = strokeEnd
        shape.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shape)
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

//
//  WeekTableViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 19/7/22.
//

import UIKit
import SDWebImage

class WeekTableViewCell: UITableViewCell {
    let title : UILabel = {
       let title = UILabel()
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .left
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    
    var imageView1 : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 230, height: 204)
        image.layer.cornerRadius = image.frame.size.width/2
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var weekDescription : UILabel = {
       var text = UILabel()
        text.numberOfLines = 0
        text.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(
            title,
            imageView1,
            weekDescription
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData(titleLabel: String, image: String, description: String) {
        let imageURL = URL(string: image.replacingOccurrences(of: "http://localhost:8080", with: "https://medtech-team5.herokuapp.com"))
        imageView1.sd_setImage(with: imageURL)
        title.text = titleLabel
        weekDescription.text =  description
    }
    
    func setUpConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(24)
        }
        
        imageView1.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(230)
            make.height.equalTo(214)
        }
        
        weekDescription.snp.makeConstraints { make in
            make.top.equalTo(imageView1.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
        }
    }

}

//
//  WeekTableViewCell.swift
//  MedTech
//
//  Created by Eldiiar on 19/7/22.
//

import UIKit
import Kingfisher

class WeekTableViewCell: UITableViewCell {
    let title : UILabel = {
       let title = UILabel()
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .center
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        title.numberOfLines = 0
        return title
    }()
    
    var imageView1 : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 230, height: 204)
        image.layer.cornerRadius = image.frame.size.width/2
        image.contentMode = .scaleAspectFit
        //image.sizeToFit()
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
    
    func setUpData(titleLabel: String?, image: String?, description: String?) {
        title.text = titleLabel
        weekDescription.text = description
        guard image != nil else {
            title.text = ""
            weekDescription.text = ""
            imageView1.image = Icons.nocontent.image
            return
        }
        imageView1.snp.remakeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(weekDescription.snp.top).offset(-30)
            make.width.equalTo(widthComputed(230))
            make.height.equalTo(heightComputed(214))
        }
        
        let imageURL = URL(string: image!)
        imageView1.kf.setImage(with: imageURL)
    }
    
//    func downloadImage(from url: URL) {
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//
//            DispatchQueue.main.async() { [weak self] in
//                self?.imageView1.image = UIImage(data: data)
//            }
//        }
//    }
//
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
    
    
    func setUpConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(3)
        }
        
        imageView1.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.width.equalTo(widthComputed(230))
            make.height.equalTo(heightComputed(214))
            make.bottom.equalTo(weekDescription.snp.top).offset(-10)
        }
        
        weekDescription.snp.makeConstraints { make in
           // make.top.equalTo(imageView1.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().offset(-30)
        }
    }

}

//
//  NotificationTableViewCell.swift
//  MedTech
//
//  Created by Adilet on 25/7/22.
//

import UIKit
import SnapKit

class NotificationTableViewCell: UITableViewCell {
    static let ID = "NotificationsPageCell"
    private lazy var heightForRaw = name.frame.height + dateTime.frame.height + 10
    var name : UILabel = {
        let name = UILabel()
        name.text = "Хафизова Валентина Владимировна отправила вам сообщение"
        name.font = Fonts.SFProText.medium.font(size: 16)
        name.textColor = UIColor(named: "Violet")
        name.numberOfLines = 0
        return name
    }()
    var dateTime : UILabel = {
        let label = UILabel()
        label.text = "Понедельник, 23 июля в 11:15"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = Fonts.SFProText.regular.font(size: 14)
        return label
    }()
    var photo : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = 30
        img.backgroundColor = .yellow
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "doctor")
        return img
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame.size.height = heightForRaw
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpSubviews(){
        contentView.addSubviews(name,
                                photo,
                                dateTime)
    }
    
    func getData(model: Notifications) {
        name.text = "\(model.header!)\n\(model.message!.replacingOccurrences(of: "<br>", with: "\n"))"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateDate = dateFormatter.date(from:model.dateCreated!)
        dateFormatter.dateFormat = "EEEE, d MMMM в HH:mm"
        dateFormatter.locale = Locale(identifier: "ru")
        let dateStr = dateFormatter.string(from: dateDate!)
        dateTime.text = dateStr.capitalizingFirstLetter()
        guard let url = URL(string: (model.patient?.doctorDTO?.imageUrl)!) else {
            return
        }
        photo.sd_setImage(with: url)
    }
    
    func setUpConstraints(){
        name.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(15)
            make.right.equalTo(photo.snp.left).offset(5)
        }
        dateTime.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        photo.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(60)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

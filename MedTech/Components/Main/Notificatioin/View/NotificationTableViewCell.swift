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
        name.font = UIFont(name: "SFProText-Medium", size: 16)

        name.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        name.numberOfLines = 0
//        name.textColor = .systemPurple
        return name
    }()
    var dateTime : UILabel = {
        let label = UILabel()
        label.text = "Понедельник, 23 июля в 11:15"
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.font = .systemFont(ofSize: 17)
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
//        contentView.backgroundColor = .systemPurple
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
        name.text = model.header!
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
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(61)
            
        }
        dateTime.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        photo.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

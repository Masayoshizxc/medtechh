//
//  AppointmentView.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import UIKit

class AppointmentView: UIView {
    
    private let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.doctor.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Хафизова Валентина Владимировна"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = Fonts.SFProText.medium.font(size: 16)
        return label
    }()

    private let jobLabel: UILabel = {
        let label = UILabel()
        label.text = "Гинеколог"
        label.textColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1)
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.calendar.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.line.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Плановый осмотр"
        label.textColor = .white
        label.font = Fonts.SFProText.medium.font(size: 18)
        return label
    }()
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.date.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Декабрь, 14"
        label.textColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1)
        label.font = Fonts.SFProText.regular.font(size: 14)
        return label
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.time.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeImgLabel: UILabel = {
        let label = UILabel()
        label.text = "11:00 - 12:00"
        label.textColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1)
        label.font = Fonts.SFProText.regular.font(size: 14)
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.location.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Ул. Уметалиева 87/1"
        label.textColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1)
        label.font = Fonts.SFProText.medium.font(size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            nameLabel,
            doctorImageView,
            jobLabel,
            calendarImageView,
            lineImageView,
            descriptionLabel,
            dateImageView,
            dateLabel,
            timeImageView,
            timeImgLabel,
            locationImageView,
            locationLabel
        )
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(model: PatientVisitDTO) {
        let urlString = model.doctorDTO?.imageUrl
        
        let image = URL(string: urlString ?? "")
        doctorImageView.sd_setImage(with: image)
        nameLabel.text = "\(model.doctorDTO!.userDTO.firstName) \(model.doctorDTO!.userDTO.lastName) \(model.doctorDTO!.userDTO.middleName)"
        jobLabel.text = model.doctorDTO?.profession?.capitalized
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateDate = dateFormatter.date(from: model.dateVisit!)
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = "LLLL, dd"
        let dateString = dateFormatter.string(from: dateDate!)
        dateLabel.text = dateString.capitalized
        timeImgLabel.text = "\(model.visitStartTime.dropLast(3)) - \(model.visitEndTime.dropLast(3))"
        locationLabel.text = model.visitAddress
    }
    
    func setUpConstraints() {
        doctorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(190)
            make.height.equalTo(64)
            make.left.equalTo(doctorImageView.snp.right).offset(20)
        }
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(-10)
            make.left.equalTo(nameLabel.snp.left)
        }
        calendarImageView.snp.makeConstraints { make in
            make.bottom.equalTo(jobLabel.snp.top)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        lineImageView.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        dateImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(dateImageView.snp.right).offset(10)
        }
        timeImageView.snp.makeConstraints { make in
            make.top.equalTo(dateImageView.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
        }
        timeImgLabel.snp.makeConstraints { make in
            make.top.equalTo(dateImageView.snp.bottom).offset(10)
            make.left.equalTo(timeImageView.snp.right).offset(10)
        }
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(timeImageView.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(timeImageView.snp.bottom).offset(10)
            make.left.equalTo(locationImageView.snp.right).offset(10)
        }
    }

}

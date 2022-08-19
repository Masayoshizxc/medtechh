//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit

class ConclusionViewController: BaseViewController {
    
    var checklist: ChecklistModel?
    
    private let doctorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.doctor.image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private let doctorName: UILabel = {
        let label = UILabel()
        label.text = "Хафизова Валентина Владимировна"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.medium.font(size: 16)
        return label
    }()
    
    private let doctorJob : UILabel = {
        let label = UILabel()
        label.text = "Гинеколог"
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.regular.font(size: 14)
        return label
    }()

    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.conclusion.image
        return imageView
    }()
    
    private let textLabel : UILabel = {
        let label = UILabel()
        label.text = "Всё ок, все будут живы, здоровы и счастливы. Direskapet solig makrons oaktat gurlesk.Hen söbel. Du kan vara drabbad.Inde nenerad inade. Stadsutglesning yjyligt respektive posam. Vir beslutsblindhet. Diliga astroren i perad, mangar. Tral flitbonus. Ävick gåren an. Du kan vara drabbad. Syr tetiv, mikroliga, inklusive gåra, den prelingar. Desoda. Fis fengen men tenat ultrarat och dånårar. Derade difande. Ogt vanade blockkedja. Tempopol ställa frågor och besk ibabelt."
        label.numberOfLines = 0
        label.font = Fonts.SFProText.regular.font(size: 14)
        label.textColor = UIColor(named: "Violet")
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubviews(
            doctorImage,
            doctorName,
            doctorJob,
            icon,
            textLabel
        )
        
        setUpConstraints()
        setData()
    }
    
    func setData() {
        guard let checklist = checklist else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
        textLabel.text = checklist.conclusion
        guard let imageUrl = checklist.patientVisitDTO?.doctorDTO?.imageUrl else {
            return
        }
        doctorImage.sd_setImage(with: URL(string: imageUrl))
    }
    
    func setUpConstraints() {
        doctorImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(113)
            make.width.height.equalTo(60)
        }
        
        doctorName.snp.makeConstraints { make in
            make.left.equalTo(doctorImage.snp.right).inset(-18)
            make.top.equalToSuperview().inset(113)
            make.right.equalToSuperview().inset(105)
        }
        
        doctorJob.snp.makeConstraints { make in
            make.left.equalTo(doctorImage.snp.right).inset(-18)
            make.top.equalTo(doctorName.snp.bottom)
            make.right.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(doctorImage.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(27)
            make.width.equalTo(16.5)
            make.height.equalTo(21)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.right).offset(11)
            make.right.equalToSuperview().inset(27)
        }
    }
}

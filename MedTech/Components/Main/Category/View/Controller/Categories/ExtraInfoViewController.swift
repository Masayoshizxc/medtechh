//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SDWebImage

class ExtraInfoViewController: BaseViewController {
    
    var checklist: ChecklistModel?
    var model = [String]()
    
    private let doctorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.extra.image
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
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Дополнительные назначения"
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.semibold.font(size: 16)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.register(ExtraInfoTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(
            doctorImage,
            doctorName,
            doctorJob,
            tableView
        )
        
        setUpConstraints()
        setData()
    }
    
    func setData() {
        guard let checklist = checklist else {
            return
        }
        guard let extra = checklist.extraInfo else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
        for i in extra.split(separator: "@") {
            model.append(String(i))
        }
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(doctorImage.snp.bottom).inset(-29)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview()
        }
    }
}

extension ExtraInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExtraInfoTableViewCell
        cell.setUpData(model: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

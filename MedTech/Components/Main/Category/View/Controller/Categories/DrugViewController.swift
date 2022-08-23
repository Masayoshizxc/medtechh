//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class DrugViewController: BaseViewController {
    
    var checklist: ChecklistModel?
    var drugsList = [String]()
    
    private let doctorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.doctor.image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private let doctorName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Violet")
        label.font = Fonts.SFProText.medium.font(size: 16)
        return label
    }()
    
    private let doctorJob : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = Fonts.SFProText.regular.font(size: 14)
        return label
    }()
    
    private lazy var titleFor : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Медикаменты"
        l.textColor = UIColor(named: "Violet")
        l.font = .boldSystemFont(ofSize: 16)
        return l
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(DrugTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        label.text = "Список медикаментов до следующего планового осмотра"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorColor = .clear
                
        setUpSubviews()
        setUpConstraints()
        setData()
    }
    
    func setUpSubviews(){
        view.addSubviews(doctorImage,
                         doctorName,
                         doctorJob,
                         titleFor,
                         tableView,
                         label
        )
    }
    
    func setData() {
        guard let checklist = checklist,
              let drugs = checklist.drugList else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
        for i in drugs.split(separator: "@") {
            drugsList.append(String(i))
        }
        guard let imageUrl = checklist.patientVisitDTO?.doctorDTO?.imageUrl else {
            return
        }
        doctorImage.sd_setImage(with: URL(string: imageUrl))
    }
    
    func setUpConstraints(){
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
        
        titleFor.snp.makeConstraints{make in
            make.top.equalTo(doctorImage.snp.bottom).offset(29)
            make.left.right.equalToSuperview().inset(27)
            
        }
        
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleFor.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(90)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(64 + tabbarHeight)
        }
        
    }
}

extension DrugViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return drugsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrugTableViewCell
        let model = drugsList[indexPath.section].split(separator: "|")
        cell.setUpData(model: Drugs(title: String(model[0]), description: String(model[1])))
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

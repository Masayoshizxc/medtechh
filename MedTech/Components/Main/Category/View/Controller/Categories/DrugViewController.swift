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
        l.text = "Особенности организма пациентки"
        l.font = .boldSystemFont(ofSize: 19)
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    private lazy var textAboutPatient : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Resäsamma astrogisk.Vir or safelogi. Kompetensväxling lyr anteledes, rens respektive ding. Pretähur vanade sedan åsiktskorridor och bemise mide. Astrona polynår. Trafävis osade, eftersom poskap att oktig."
        l.textColor = UIColor(named: "Violet")
        l.font = .systemFont(ofSize: 14)
        
        return l
    }()
    private lazy var titleFor1 : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Медикаменты"
        l.textColor = UIColor(named: "Violet")
        l.font = .systemFont(ofSize: 16)
        
        return l
    }()
    private lazy var tableView : UITableView = {
        let t = UITableView()
        t.register(DrugTableViewCell.self, forCellReuseIdentifier: DrugTableViewCell.reuseIdentifier)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .purple
        return t
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpConstraints()
        setData()
    }
    
    func setUpSubviews(){
        view.addSubviews(doctorImage,
                         doctorName,
                         doctorJob,
                         titleFor,
                         textAboutPatient,
                         titleFor1,
                         tableView)
    }
    
    func setData() {
        guard let checklist = checklist,
              let drugs = checklist.drugList?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
        print(drugs.split(separator: ","))
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
            make.right.equalToSuperview()
        }
        
        doctorJob.snp.makeConstraints { make in
            make.left.equalTo(doctorImage.snp.right).inset(-18)
            make.top.equalTo(doctorName.snp.bottom)
            make.right.equalToSuperview()
        }
        
        titleFor.snp.makeConstraints{make in
            make.top.equalTo(doctorImage.snp.bottom).offset(29)
            make.left.equalToSuperview().inset(27)
            
        }
        textAboutPatient.snp.makeConstraints{make in
            make.top.equalTo(titleFor.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
            
        }
        titleFor1.snp.makeConstraints{make in
            make.top.equalTo(textAboutPatient.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
            
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleFor1.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
        }
    }
}

extension DrugViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrugTableViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemPink
        cell.textLabel?.text = "Hello Kitty"
        return cell
    }
    
    
}

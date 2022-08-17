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
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(DrugCollectionViewCell.self, forCellWithReuseIdentifier: DrugCollectionViewCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
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
                         collectionView)
    }
    
    func setData() {
        guard let checklist = checklist,
              let drugs = checklist.drugList?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
        for i in drugs.split(separator: ",") {
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
            make.right.equalToSuperview()
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
        
        
        collectionView.snp.makeConstraints{make in
            make.top.equalTo(titleFor.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(90)
        }
        
    }
}

extension DrugViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drugsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(DrugCollectionViewCell.self, indexPath: indexPath)
        cell.setUpData(model: drugsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 67)
    }
    
    
}

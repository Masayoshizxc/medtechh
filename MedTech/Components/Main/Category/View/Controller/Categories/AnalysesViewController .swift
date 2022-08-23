//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class AnalysesViewController: BaseViewController {
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
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(AnalysesCollectionViewCell.self, forCellWithReuseIdentifier: AnalysesCollectionViewCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Violet")
        label.textAlignment = .center
        label.text = "Список данных анализов должен быть сдан до следующего планового осмотра"
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setData()
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews(){
        view.addSubviews(doctorImage,
                         doctorName,
                         doctorJob,
                         collectionView,
                         label
        )
    }
    
    func setData() {
        guard let checklist = checklist else {
            return
        }
        let doctor = checklist.patientVisitDTO?.doctorDTO
        doctorName.text = "\(doctor!.userDTO.lastName) \(doctor!.userDTO.firstName) \(doctor!.userDTO.middleName)"
        doctorJob.text = doctor?.profession
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
        
        collectionView.snp.makeConstraints{make in
            make.top.equalTo(doctorJob.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(90)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(64 + tabbarHeight)
        }
        
    }
}

extension AnalysesViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (checklist?.analyzes!.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnalysesCollectionViewCell.reuseID, for: indexPath) as! AnalysesCollectionViewCell
        guard let analyzes = checklist?.analyzes else {
            return cell
        }
        cell.setUpData(model: analyzes[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return (CGSize(width: view.frame.size.width, height: 60))
    }
}

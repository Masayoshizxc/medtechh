//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class DrugViewController: BaseViewController {
    private lazy var doctorImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "doctor")
        img.layer.cornerRadius = img.frame.size.width/2
        
        return img
    }()
    private lazy var doctorName : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 16)
        l.text = "Хафизова Валентина Владимировна"
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    private lazy var doctorPos : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Гинеколог"
        l.textColor = UIColor(named: "LightViolet")
        l.font = .systemFont(ofSize: 14)
        return l
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
        
    }
    
    func setUpSubviews(){
        view.addSubviews(doctorImage,
                         doctorName,
                         doctorPos,
                         titleFor,
                         collectionView)
    }
    
    func setUpConstraints(){
        doctorImage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(113)
            make.left.equalToSuperview().inset(27)
            make.width.height.equalTo(60)
        }
        doctorName.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(115)
            make.left.equalTo(doctorImage.snp.right).offset(18)
            make.right.equalToSuperview().inset(27)
            make.height.equalTo(38)
        }
        doctorPos.snp.makeConstraints{make in
            make.top.equalTo(doctorName.snp.bottom)
            make.left.equalTo(doctorImage.snp.right).offset(18)
            make.height.equalTo(18)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrugCollectionViewCell.reuseID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width-54, height: 67)
    }
    
    
}

//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class QuestionAnswerViewController: BaseViewController {
        
    var id: Int?
    private let viewModel: ChecklistViewModelProtocol
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        l.text = "Обследование"
        l.font = .boldSystemFont(ofSize: 19)
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(QuestionsAnswersCell.self)
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
//        collection.backgroundColor = .purple
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpConstraints()
        
        viewModel.getAnswers(id: 2, completion: { result in
            switch result {
            case .success:
                print(self.viewModel.answers as Any)
            case .failure:
                print("There was an error with downloading answers!")
            default:
                break
            }
        })
    }
    
    func setUpSubViews(){
        view.addSubviews(collectionView,
                         doctorImage,
                         doctorName,
                         doctorPos,
                         titleFor)
    }
    
    func setUpConstraints(){
        collectionView.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(27)
            make.top.equalTo(237)
            make.bottom.equalToSuperview().inset(90)
            
        }
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
            make.left.equalToSuperview().inset(27)
            
        }
    }

}

extension QuestionAnswerViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionsAnswersCell.ID, for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
    
}

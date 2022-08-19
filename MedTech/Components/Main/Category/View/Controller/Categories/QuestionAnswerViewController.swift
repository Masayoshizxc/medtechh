//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class QuestionAnswerViewController: BaseViewController {
        
    private let viewModel: ChecklistViewModelProtocol
    var checklist: ChecklistModel?
    var answers: Answers?
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        
        setData()
        setUpSubViews()
        setUpConstraints()
        getAnswers()
    }
    
    func setUpSubViews(){
        view.addSubviews(collectionView,
                         doctorImage,
                         doctorName,
                         doctorJob
        )
    }
    
    func getAnswers() {
        guard let checklist = checklist, let id = checklist.id else {
            return
        }
        
        viewModel.getAnswers(id: id, completion: { result in
            switch result {
            case .success:
                print("Successfule")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure:
                print("There was an error with downloading answers!")
            default:
                break
            }
        })
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
//            make.top.equalToSuperview().inset(113)
            make.right.equalToSuperview()
            make.bottom.equalTo(doctorImage.snp.centerY)
        }
        
        doctorJob.snp.makeConstraints { make in
            make.left.equalTo(doctorImage.snp.right).inset(-18)
            make.top.equalTo(doctorName.snp.bottom)
            make.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(27)
            make.top.equalTo(200)
            make.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }

}

extension QuestionAnswerViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checklist?.basic_questions?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(QuestionsAnswersCell.self, indexPath: indexPath)
        guard let questions = checklist?.basic_questions, let answers = viewModel.answers else {
            return cell
        }
        cell.setUpData(model: questions[indexPath.row], answer: answers[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 150)
    }
    
}

//
//  QuestionsAnswersCell.swift
//  MedTech
//
//  Created by Adilet on 14/8/22.
//

import UIKit
import SnapKit

class QuestionsAnswersCell: UICollectionViewCell {
    static let ID = "QuestionsAnswersCell"

    private lazy var questionIcon : UIImageView = {
        let img = UIImageView()
        img.image = Icons.question.image
        return img
    }()
    private lazy var questionLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Violet")
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let answerLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightViolet")
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpSubviews(){
        contentView.addSubviews(questionIcon,
                                questionLabel,
                                answerLabel,
                                image)
    }
    
    func setUpData(model: Basic_questions, answer: Answers) {
        questionLabel.text = model.questionString
        answerLabel.text = answer.answerString
        guard let status = answer.answerStatus else {
            return
        }
        if status {
            image.image = Icons.checkmark2.image
        } else {
            image.image = Icons.xmark.image
        }
        
    }
    
    func setUpConstraints(){
        questionIcon.snp.makeConstraints{make in
            make.width.height.equalTo(21)
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(2)
        }
        questionLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(5)
            make.left.equalTo(questionIcon.snp.right).offset(10)
            make.right.equalTo(image.snp.left).inset(-16)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(13)
            make.left.equalTo(questionIcon.snp.right).offset(10)
            make.right.equalTo(image.snp.left).inset(-16)
        }
        
        image.snp.makeConstraints{make in
            make.bottom.equalTo(answerLabel.snp.top)
            make.right.equalToSuperview().inset(16)
            make.width.height.equalTo(24)
        }

    }
}

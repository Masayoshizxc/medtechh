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
    
    private lazy var button : UILabel = {
        let btn = UILabel()
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor(named: "Violet")
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.cornerRadius = 16
        btn.textAlignment = .center
        btn.text = "Да"
        btn.font = Fonts.SFProText.semibold.font(size: 16)
        btn.textColor = .white
        return btn
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        button.isHidden = true
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
                                button)
    }
    
    func setUpData(model: Basic_questions, answer: Answers) {
        questionLabel.text = model.questionString
        answerLabel.text = answer.answerString
        guard let status = answer.answerStatus else {
            return
        }
        button.isHidden = false
        if status {
            button.text = "Да"
            button.backgroundColor = UIColor(named: "Violet")
        } else {
            button.text = "Нет"
            button.backgroundColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1)
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
            make.right.equalToSuperview().inset(5)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(13)
            make.left.equalTo(questionIcon.snp.right).offset(10)
            make.right.equalToSuperview().inset(27)
        }
        
        button.snp.makeConstraints{make in
            make.top.equalTo(answerLabel.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(40)
        }

    }
}

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
    
//    private lazy var viewForQuestion : UIView = {
//        let view = UIView()
//        view.backgroundColor = .purple
//        view.addSubview(yesButton)
//        return view
//    }()
//
    private lazy var questionIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "checkQuestion")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var questionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Употребляла ли пациентка ( в настоящем и прошлом ) табак ? Пассивное что за хуйня ?йвойдцловдйлцовшфыовщшцйошв"
        
        label.textColor = UIColor(named: "LightViolet")
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        
        
        return label
    }()
    private lazy var yesButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "Violet")
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        btn.setTitle("Да", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private lazy var noButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "LightViolet")
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        btn.setTitle("Нет", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        return btn
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
                                yesButton,
                                noButton)
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        yesButton.frame = contentView.bounds
//    }
    
    @objc func yesButtonTapped(){
        print("Yes sir")
    }
    
    func setUpConstraints(){
        questionIcon.snp.makeConstraints{make in
            make.width.height.equalTo(21)
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(2)
        }
        questionLabel.snp.makeConstraints{make in
            make.height.equalTo(70)
            make.top.equalToSuperview().inset(-5)
            make.left.equalTo(questionIcon.snp.right).offset(10)
            make.right.equalToSuperview().inset(5)
        }
        yesButton.snp.makeConstraints{make in
            make.top.equalTo(questionLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        noButton.snp.makeConstraints{make in
            make.top.equalTo(questionLabel.snp.bottom).offset(2)
            make.right.equalToSuperview().inset(100)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
    }
}

//
//  NotificationsViewController.swift
//  MedTech
//
//  Created by Adilet on 17/6/22.
//

import UIKit
import SnapKit

class NotificationsViewController: UIViewController {
    let exitButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    let titleForPage : UILabel = {
        let title = UILabel()
        title.text = "Уведомления"
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
//    background: rgba(92, 72, 106, 1);
        title.font = .boldSystemFont(ofSize: 29)
        return title
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    let messageView : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1).cgColor
        view.frame.size.width = CGFloat(336)
        view.frame.size.height = CGFloat(402)
        return view
    }()
    let messageTitle : UILabel = {
        let title = UILabel()
        title.text = "Первичный осмотр"
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        title.font = .boldSystemFont(ofSize: 24)
        return title
    }()
    let patientsTitle : UILabel = {
        let title = UILabel()
        title.text = "Ваше решение"
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        title.font = .boldSystemFont(ofSize: 20)
        return title
    }()
    let patientsDay : UILabel = {
        let title = UILabel()
        title.text = "  Декабрь, 14"
        title.addImageWith(name: "notifDay", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    let patientsTime : UILabel = {
        let title = UILabel()
        title.text = "  11:00 - 12:00"
        title.addImageWith(name: "notifTime", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    let patientsLocation : UILabel = {
        let title = UILabel()
        title.text = "  Ул. Уметалиева 87/1"
        title.addImageWith(name: "notifLocation", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    let dividingLine : UIView = {
        let line = UIView()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1).cgColor
        return line
    }()
    let doctorsTitle : UILabel = {
        let title = UILabel()
        title.text = "Изменения вснесённые врачом"
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        title.font = .boldSystemFont(ofSize: 20)
        return title
    }()
    let doctorsDay : UILabel = {
        let title = UILabel()
        title.text = "  Декабрь, 14"
        title.addImageWith(name: "notifDay", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    let doctorsTime : UILabel = {
        let title = UILabel()
        title.text = "  11:00 - 12:00"
        title.addImageWith(name: "notifTime", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    let doctorsLocation : UILabel = {
        let title = UILabel()
        title.text = "  Ул. Уметалиева 87/1"
        title.addImageWith(name: "notifLocation", behindText: false)
        title.textColor = UIColor(red: 160/255, green: 150/255, blue: 167/255, alpha: 1)
        title.font = .systemFont(ofSize: 17)
        return title
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
        setUpScrollView()
        setUpConstraints()
    }
    func setUpSubviews(){
        view.addSubviews(exitButton,
                         titleForPage,
                         scrollView)
        scrollView.addSubview(messageView)
        messageView.addSubviews(messageTitle,
                                patientsTitle,
                                patientsDay,
                                patientsTime,
                                patientsLocation,
                                dividingLine,
                                doctorsTitle,
                                doctorsDay,
                                doctorsTime,
                                doctorsLocation)
    }
    func setUpScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 2000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    func setUpConstraints(){
        exitButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().inset(70)
            make.right.equalToSuperview().inset(30)
        }
        titleForPage.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(111)
        }
        scrollView.snp.makeConstraints{make in
            make.top.equalTo(titleForPage.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
        }
//        scrollable.snp.makeConstraints{make in
//            make.top.left.right.bottom.equalToSuperview()
//            make.centerX.equalToSuperview()
//        }
        messageView.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
            make.height.equalTo(402)
        }
        messageTitle.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        patientsTitle.snp.makeConstraints{make in
            make.top.equalTo(messageTitle.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(20)
        }
        patientsDay.snp.makeConstraints{make in
            make.top.equalTo(patientsTitle.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        patientsTime.snp.makeConstraints{make in
            make.top.equalTo(patientsDay.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        patientsLocation.snp.makeConstraints{make in
            make.top.equalTo(patientsTime.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        dividingLine.snp.makeConstraints{make in
            make.top.equalTo(patientsLocation.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        doctorsTitle.snp.makeConstraints{make in
            make.top.equalTo(dividingLine.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(20)
        }
        doctorsDay.snp.makeConstraints{make in
            make.top.equalTo(doctorsTitle.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        doctorsTime.snp.makeConstraints{make in
            make.top.equalTo(doctorsDay.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        doctorsLocation.snp.makeConstraints{make in
            make.top.equalTo(doctorsTime.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(21.5)
        }
        
    }
    

}

extension UILabel {

    func addImageWith(name: String, behindText: Bool) {

        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)

        guard let txt = self.text else {
            return
        }

        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}

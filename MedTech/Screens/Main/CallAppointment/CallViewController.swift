//
//  CallViewController.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import UIKit

class CallViewController: UIViewController {

    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        button.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        button.setImage(Icons.call.image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        button.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        button.setImage(Icons.calendar.image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubviews(
            callButton,
            calendarButton
        )
        
        setUpConstraints()
    }
    
    @objc func didTapCallButton() {
        print("Call button tapped")
    }
    
    @objc func didTapCalendarButton() {
        print("Calendar button tapped")
    }
    
    func setUpConstraints() {
        callButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(160)
            make.width.equalTo(160)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(160)
            make.width.equalTo(160)
        }
    }
}

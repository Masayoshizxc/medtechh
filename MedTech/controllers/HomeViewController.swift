//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsBackgroundColor()
//        setUpTitle()
        setUpCollectionView()
        view.addSubview(topic)
        setUpButtons()
    }
// Colors*******
    func setUpViewsBackgroundColor(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 245/255, green: 185/255, blue: 200/255, alpha: 1).cgColor,
            UIColor(red: 254/255, green: 247/255, blue: 217/255, alpha: 1).cgColor
        ]
        view.layer.addSublayer(gradientLayer)
    }
//*********
//    func setUpTitle(){
//        var title = UILabel()
//        view.addSubview(title)
//
//        title.text = "Ваша неделя беременности"
//        title.font = UIFont(name: "System", size: 25)
//        title.textColor = .black
//
//        title.snp.makeConstraints{make in
//            make.top.equalToSuperview().inset(100)
//            make.left.equalToSuperview().inset(30)
//        }
//
//    }
    
//    Adding collectionview to the home page
    private var collectionView = GalleryCollectionView()
    func setUpCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        collectionView.layer.cornerRadius = 300
        
    }

//    Topic View
    let topic : UIView = {
      let vieww = UIView(frame: CGRect(x: 35, y: 200, width: 354, height: 600))
        vieww.layer.cornerRadius = 30
        vieww.backgroundColor = .white
        
        let weekImage : UIImageView = {
           let image = UIImageView()
//            image.snp.makeConstraints{make in
//                make.top.equalTo(vieww).inset(20)
//                make.leading.equalTo(vieww).inset(20)
//                make.height.equalTo(60)
//                make.width.equalTo(30)
//            }
            image.self.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 30, height: 60))
            image.backgroundColor = .systemPurple
            return image
        }()
        vieww.addSubview(weekImage)
        return vieww
    }()
    
    
//  Notifications
    func setUpButtons(){
    let notificationButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
        button.tintColor = .white
        return button
    }()
        
        view.addSubview(notificationButton)
        
        notificationButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
        }
        let messagesButton : UIButton = {
           let button = UIButton()
            button.setBackgroundImage(UIImage(systemName: "envelope.open"), for: .normal)
            button.tintColor = .white
            return button
        }()
        
        view.addSubview(messagesButton)
        
        messagesButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
        }
    }
//
    
}


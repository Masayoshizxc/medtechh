//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let messagesButton : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "envelope.open"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let notificationButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait) 
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: [0, 20], at: .centeredHorizontally, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsBackgroundColor()
        setUpCollectionView()
        view.addSubview(topic)
        setUpButtons()
        topic.addSubview(weekImage)
        weekImage.centerXAnchor.constraint(equalTo: topic.centerXAnchor).isActive = true
        topic.addSubview(textTopic)
        collectionView.showsHorizontalScrollIndicator = false
        
        setUpConstraints()
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

//    Adding collectionview to the home page
    private var collectionView = GalleryCollectionView()
    func setUpCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.set(cells: ForWeeks.fetchForWeeks())
        
    }

//    Topic View
    let topic : UIView = {
      let vieww = UIView()
        vieww.layer.cornerRadius = 30
        vieww.backgroundColor = .white
        vieww.translatesAutoresizingMaskIntoConstraints = false
        return vieww
    }()
    
    let weekImage : UIImageView = {
       let image = UIImageView()
        image.frame = CGRect(x: (354/2) - 50 , y: 10, width: 100, height: 100)
        image.layer.cornerRadius = 40
        image.image = UIImage(named: "week1")
        return image
    }()
    
    var textTopic : UILabel = {
       var text = UILabel()
        text.text = ("Акушеры считают срок гестации с первого дня последней менструации. Это удобно — ведь большинство женщин ведут календарь и знают эту дату. Однако плода в это период еще нет. Зачатие случается позже — во время овуляции, примерно через две недели. Можно было бы считать срок гестации и с момента зачатия, но эту дату сложно вычислить. К тому же овуляция может наступить не в середине цикла, а значительно раньше или позже — и тогда вычислить ее будет еще сложнее.")
        text.numberOfLines = 0
        text.frame = CGRect(x: 30, y: (10+100+20), width: 354 - 60, height: 400)
        return text
    }()
    
    
    
//  Notifications
    func setUpButtons(){
        view.addSubview(notificationButton)
        view.addSubview(messagesButton)
    }
    
    func setUpConstraints() {
        topic.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            //make.width.equalTo(354)
            //make.height.equalTo(600)
            make.bottom.equalToSuperview().inset(120)
        }
        
        messagesButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }
        
        notificationButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }
    }
//
    
}


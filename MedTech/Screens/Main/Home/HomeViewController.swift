//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let titleForPage : UILabel = {
        var title = UILabel()
        title.text = "Главная"
        title.textColor = .black
//        title.font = title.font.withSize(25)
        title.font = .boldSystemFont(ofSize: 25)
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    let notificationsButton : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.badge"), for: .normal)
        
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return button
    }()
    
    let sosButton : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
//        button.setTitleShadowColor(.black, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 16
        
        return button
    }()
    
    let remindButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.currentImage?.withTintColor(UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1))
        button.setTitle("  Следующее посещение 30-июля", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 14)
        button.setTitleColor(UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1), for: .normal)
        return button
    }()
    

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
        text.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return text
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
        badgeLabel(withCount: 5)
        showBadge(withCount: 5)
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
//        view.addSubview(topic)
//        setUpButtons()
//        topic.addSubview(weekImage)
//        weekImage.centerXAnchor.constraint(equalTo: topic.centerXAnchor).isActive = true
//        topic.addSubview(textTopic)
        collectionView.showsHorizontalScrollIndicator = false
        
        setUpSubViews()
        setUpConstraints()

    }
    
    
    func setUpSubViews(){
        view.addSubviews(topic,sosButton,notificationsButton,titleForPage,remindButton)
        topic.addSubviews(weekImage, textTopic)
    }
// Colors*******
    func setUpViewsBackgroundColor(){
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [
//            UIColor(red: 245/255, green: 185/255, blue: 200/255, alpha: 1).cgColor,
//            UIColor(red: 254/255, green: 247/255, blue: 217/255, alpha: 1).cgColor
//        ]
//        view.layer.addSublayer(gradientLayer)
        view.backgroundColor = .white
    }

//    Adding collectionview to the home page
    private var collectionView = GalleryCollectionView()
    func setUpCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.set(cells: ForWeeks.fetchForWeeks())
        
    }
    
    
    let badgeSize: CGFloat = 20
    let badgeTag = 9830384

    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(count)
        return badgeCount
    }
    
    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        notificationsButton.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: notificationsButton.leftAnchor, constant: 14),
            badge.topAnchor.constraint(equalTo: notificationsButton.topAnchor, constant: -4),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }


    
    
    
    
//    Topic View
    
    
    
    
//  Notifications
   
    func setUpConstraints() {
        topic.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(354)
            make.height.equalTo(600)
            make.bottom.equalToSuperview().inset(120)
        }
        
        
        
        notificationsButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }
        
        sosButton.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(65)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        titleForPage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
        }
        weekImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
        }
        remindButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleForPage).inset(50)
            
        }
    }
//
    
}


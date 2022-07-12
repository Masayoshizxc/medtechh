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
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
//        scroll.layer.cornerRadius = 30
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let weekImage : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 230, height: 204)
        image.layer.cornerRadius = image.frame.size.width/2
        image.image = UIImage(named: "child")
        return image
    }()
    
    let constTitle : UILabel = {
       let title = UILabel()
        title.text = "Что есть во время беременности?"
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .left
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    
    let recImage : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 336, height: 220)
        image.image = UIImage(named: "eat")
        return image
    }()
    
    var textTopic : UILabel = {
       var text = UILabel()
        text.text = ("Во время беременности очень важно правильно питаться: сбалансированный рацион будущей мамы один из источников необходимых компонентов для правильного развития малыша.\nДля беременной женщины «есть за двоих» должно означать не «есть в два раза больше», а «есть в два раза лучше». Правильное питание во время беременности важно не только с точки зрения здоровья будущего ребенка. Это поможет вам лучше себя чувствовать, меньше уставать, не даст набрать лишние килограммы и поможет быстро прийти в форму после родов. Вот несколько полезных рекомендаций1:\nЕшьте часто, небольшими порциями.\nПейте много жидкости.\nПитайтесь разнообразно, ешьте мясо, рыбу, птицу, яйца, молочные продукты, каши, супы, фрукты, овощи, зерновые.\nЕсли вы испытываете тошноту, можно попробовать утолить голод с помощью сухих соленых крекеров и печенья.\nИзбегайте жирную пищу, жареное, острое, копченое и сладкое")
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
        setUpScrollView()
        setUpViewsBackgroundColor()
        setUpCollectionView()
        collectionView.showsHorizontalScrollIndicator = false
        setUpSubViews()
        setUpConstraints()
        
        collectionView.backgroundColor = .white
    }
    
    func setUpScrollView(){
        scrollView.contentSize = CGSize(width: textTopic.frame.size.width, height: (weekImage.frame.size.height + textTopic.frame.size.height + constTitle.frame.size.height + recImage.frame.size.height + 300))
    }
    
    func setUpSubViews(){
        view.addSubviews(sosButton,
                         notificationsButton,
                         titleForPage,
                         remindButton,
                         scrollView)
        scrollView.addSubviews(weekImage,
                               textTopic,
                               constTitle,
                               recImage)
        
        
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
        scrollView.snp.makeConstraints{make in
            make.top.equalTo(collectionView).inset(60)
            make.left.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(80)
        }
//        collectionView.snp.makeConstraints{make in
//            make.top.equalToSuperview().inset(10)
//            make.height.equalTo(50)
//            make.leading.trailing.equalTo(3)
//        }
        
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
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        remindButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleForPage).inset(70)
            
        }
        constTitle.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weekImage).inset(278)
            make.height.equalTo(24)
            
        }
        recImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(constTitle).inset(34)
        }
        textTopic.snp.makeConstraints{make in
            make.top.equalTo(recImage).inset(240)
            make.width.equalTo(336)
            make.centerX.equalToSuperview()
        }
    }
//
    
}

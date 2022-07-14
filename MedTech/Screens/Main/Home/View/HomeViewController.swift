//
//  ViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol

    init(vm: HomeViewModelProtocol = HomeViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    lazy var sosButton : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        return button
    }()
    
    let remindButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
//        button.currentImage?.withTintColor(UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1))
        button.setTitle("  Следующее посещение 30-июля", for: .normal)
        button.backgroundColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 14)
        button.setTitleColor(.white , for: .normal)
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
    var weekImage : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 230, height: 204)
        image.layer.cornerRadius = image.frame.size.width/2
        //image.image = UIImage(named: "child")
        return image
    }()
    
    let constTitle : UILabel = {
       let title = UILabel()
        //title.text = "Что есть во время беременности?"
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .left
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return title
    }()
    var textTopic1 : UILabel = {
       var text = UILabel()
        //text.text = ("В 14 недель беременности мозг и нервная система ребенка развиваются семимильными шагами. Малыш становится чувствительнее, считается, что он уже способен ощущать настроение мамы, а на фото плода, сделанного учеными, можно увидеть различные гримасы – от подобия улыбки до выражения недовольства.")
        text.numberOfLines = 0
        text.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        return text
    }()
    let recImage : UIImageView = {
       let image = UIImageView()
        image.frame.size = CGSize(width: 336, height: 220)
        //image.image = UIImage(named: "eat")
        return image
    }()
    
    var textTopic2 : UILabel = {
       var text = UILabel()
        //text.text = ("Во время беременности очень важно правильно питаться: сбалансированный рацион будущей мамы один из источников необходимых компонентов для правильного развития малыша.\nДля беременной женщины «есть за двоих» должно означать не «есть в два раза больше», а «есть в два раза лучше». Правильное питание во время беременности важно не только с точки зрения здоровья будущего ребенка. Это поможет вам лучше себя чувствовать, меньше уставать, не даст набрать лишние килограммы и поможет быстро прийти в форму после родов. Вот несколько полезных рекомендаций1:\nЕшьте часто, небольшими порциями.\nПейте много жидкости.\nПитайтесь разнообразно, ешьте мясо, рыбу, птицу, яйца, молочные продукты, каши, супы, фрукты, овощи, зерновые.\nЕсли вы испытываете тошноту, можно попробовать утолить голод с помощью сухих соленых крекеров и печенья.\nИзбегайте жирную пищу, жареное, острое, копченое и сладкое")
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
        collectionView.scrollToItem(at: [0, 0], at: .centeredHorizontally, animated: true)
        
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
        
        viewModel.getWeek(week: "1") { result in
            print(result)
            if result!.count >= 2 {
                self.constTitle.text = result?[1].header ?? ""
                self.textTopic1.text = result?[0].description ?? ""
                self.textTopic2.text = result?[1].description ?? ""
                DispatchQueue.main.async { [weak self] in
                    guard result![0].imageUrl != nil, result![1].imageUrl != nil else {
                        print("There was an error")
                        return
                    }
                    guard let image1 = URL(string: (result?[0].imageUrl)!),
                            let image2 = URL(string: (result?[1].imageUrl)!) else {
                        print("There was an error with downloading an images")
                        return
                    }
                    
                    if let imageData = try? Data(contentsOf: image1) {
                        if let loadedImage = UIImage(data: imageData) {
                            self?.weekImage.image = loadedImage
                        }
                    }
                    if let imageData = try? Data(contentsOf: image2) {
                        if let loadedImage = UIImage(data: imageData) {
                            self?.recImage.image = loadedImage
                        }
                    }
                }
            } else {
                print("There was an error with downloading")
            }
            

        }
        
        collectionView.backgroundColor = .white
        //badgeLabel(withCount: 5)
        showBadge(withCount: 5)
    }
    
    @objc func didTapSosButton() {
        print("Tapped")
    }
    
    
    
    func setUpScrollView(){
        let scrollSize = weekImage.frame.size.height + textTopic2.frame.size.height + constTitle.frame.size.height + recImage.frame.size.height + textTopic1.frame.size.height
        scrollView.contentSize = CGSize(width: textTopic2.frame.size.width, height: scrollSize + 500)
    }
    
    func setUpSubViews(){
        view.addSubviews(sosButton,
                         notificationsButton,
                         titleForPage,
                         remindButton,
                         scrollView)
        scrollView.addSubviews(weekImage,
                               textTopic1,
                               textTopic2,
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 212).isActive = true
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
        badgeCount.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
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
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        remindButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleForPage).inset(70)
            make.width.equalTo(336)
            make.height.equalTo(44)
        }
        textTopic1.snp.makeConstraints{make in
            make.top.equalTo(weekImage.snp.bottom).inset(-32)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            
        }
        constTitle.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textTopic1.snp.bottom).inset(-64)
            make.height.equalTo(24)
            
        }
        recImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(constTitle.snp.bottom).inset(-10)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        textTopic2.snp.makeConstraints{make in
            make.top.equalTo(recImage.snp.bottom).inset(-20)
            make.width.equalTo(336)
            make.centerX.equalToSuperview()
        }
    }
//
    
}


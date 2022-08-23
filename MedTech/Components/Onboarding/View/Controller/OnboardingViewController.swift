//
//  OnboardingViewController.swift
//  MedTech
//
//  Created by Eldiiar on 12/8/22.
//

import UIKit

class OnboardingViewController: BaseViewController {
    
    var onboarding = [Onboarding]()
    
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == onboarding.count - 1 {
                nextButton.isHidden = false
            } else {
                nextButton.isHidden = true
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCollectionViewCell.self)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(UIColor(named: "LightViolet"), for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    let pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPageIndicatorTintColor = UIColor(named: "Violet")
        pageController.numberOfPages = 4
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = UIColor(red: 0.933, green: 0.941, blue: 0.957, alpha: 1)
        return pageController
    }()
    
    private lazy var nextButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Начать", for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Violet")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        navigationController?.navigationBar.isHidden = true
        nextButton.isHidden = true
        
        pageController.isUserInteractionEnabled = false
        
        view.addSubviews(
            collectionView,
            pageController,
            skipButton,
            nextButton
        )
        
        onboarding.append(Onboarding(image: Icons.onboarding1.image, title: "Индикатор прогресса", description: "Наблюдайте за прогрессом вашей беременности благодаря нашей инновационной функции прогресс бара"))
        onboarding.append(Onboarding(image: Icons.onboarding2.image, title: "Кнопка “SOS”", description: "В экстренном случае вы можете использовать кнопку “SOS” для экстренной медицинской помощи"))
        onboarding.append(Onboarding(image: Icons.onboarding3.image, title: "Онлайн-запись", description: "Вы можете выбрать время приема прямо в приложении без каких-либо проблем."))
        onboarding.append(Onboarding(image: Icons.onboarding4.image, title: "Чеклисты", description: "У вас есть возможность самостоятельно просмотреть результаты анализов или назначения врачей в нашем приложении"))
        
        setUpConstraints()
    }
    
    @objc func didTapSkipButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func didTapNextButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func setUpConstraints() {
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(pageController).inset(40)
        }
        
        pageController.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(heightComputed(-60))
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(heightComputed(60))
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(40)
        }
    }
    


}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(OnboardingCollectionViewCell.self, indexPath: indexPath)
        cell.getData(onboarding[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 10, height: 600)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width - 10
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}

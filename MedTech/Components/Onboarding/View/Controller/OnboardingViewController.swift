//
//  OnboardingViewController.swift
//  MedTech
//
//  Created by Eldiiar on 12/8/22.
//

import UIKit

class OnboardingViewController: BaseViewController {
    
    var onboarding = [Onboarding]()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(
            collectionView,
            pageController,
            skipButton)
        
        onboarding.append(Onboarding(image: Icons.onboarding1.image, title: "Индикатор прогресса", description: "Наблюдайте за прогрессом вашей беременности благодаря нашей инновационной функции прогресс бара"))
        onboarding.append(Onboarding(image: Icons.onboarding2.image, title: "Кнопка “SOS”", description: "В экстренном случае вы можете использовать кнопку “SOS” для экстренной медицинской помощи"))
        onboarding.append(Onboarding(image: Icons.onboarding3.image, title: "Онлайн-запись", description: "Вы можете выбрать время приема прямо в приложении без каких-либо проблем."))
        onboarding.append(Onboarding(image: Icons.onboarding4.image, title: "Чеклисты", description: "У вас есть возможность самостоятельно просмотреть результаты анализов или назначения врачей в нашем приложении"))
        
        setUpConstraints()
    }
    
    @objc func didTapSkipButton() {
        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
    
    func setUpConstraints() {
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
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
            make.bottom.equalToSuperview().offset(-30)
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
    
}

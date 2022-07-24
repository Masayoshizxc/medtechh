//
//  TabBarViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

fileprivate enum TabbarItems: CaseIterable {
    case first
    case second
    case third
    case fourth
    
    var tabbarItem: UITabBarItem {
        switch self {
        case .first:
            return .init(
                title: "Главная",
                image: .init(named: "home"),
                tag: 1
            )
        case .second:
            return .init(
                title: "Запись",
                image: .init(named: "appointment"),
                tag: 1
            )
        case .third:
            return .init(
                title: "Чек-лист",
                image: .init(named: "checklist"),
                tag: 1
            )
        case .fourth:
            return .init(
                title: "Профиль",
                image: .init(named: "profile"),
                tag: 1
            )
        }
    }

    var navigationController: UINavigationController {
        let viewController: UINavigationController!
        switch self {
        case .first:
            viewController = .init(rootViewController: HomeViewController())
        case .second:
            viewController = .init(rootViewController: AppointmentViewController())
            viewController.navigationBar.backgroundColor = .white
            viewController.navigationBar.barTintColor = .white
        case .third:
            viewController = .init(rootViewController: ChecklistViewController())
            viewController.navigationBar.backgroundColor = .white
            viewController.navigationBar.barTintColor = .white
        case .fourth:
            viewController = .init(rootViewController: ProfileViewController())
        }
        viewController.tabBarItem = tabbarItem
        return viewController
    }
}

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        UITabBar.appearance().tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureTabs() {
        setViewControllers(TabbarItems.allCases.map { $0.navigationController }, animated: true)
    }
}

//class TabBarViewController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Tab Bar"
//
//        let vc1 = HomeViewController()
//        let vc2 = AppointentViewController()
//        let vc3 = ChecklistViewController()
//        let vc4 = ProfileViewController()
//
//
//        vc2.title = "Запись"
//        vc3.title = "Чек-лист"
//        vc4.title = "Профиль"
//
//        let nav1 = UINavigationController(rootViewController: vc1)
//        let nav2 = UINavigationController(rootViewController: vc2)
//        let nav3 = UINavigationController(rootViewController: vc3)
//        //let nav4 = UINavigationController(rootViewController: vc4)
//
//        nav1.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), tag: 1)
//        nav2.tabBarItem = UITabBarItem(title: "Запись", image: UIImage(named: "appointment"), tag: 1)
//        nav3.tabBarItem = UITabBarItem(title: "Чек-лист", image: UIImage(named: "checklist"), tag: 1)
//        vc4.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 1)
//
//
//        setViewControllers([nav1, nav2, nav3, vc4], animated: false)
//    }
//
//}

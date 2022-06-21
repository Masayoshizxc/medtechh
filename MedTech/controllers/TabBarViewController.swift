//
//  TabBarViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = AppointentViewController()
        let vc3 = ChecklistViewController()
        let vc4 = ProfileViewController()
        
        
        vc2.title = "Запись"
        vc3.title = "Чек-лист"
        vc4.title = "Профиль"
    
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Запись", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Чек-лист", image: UIImage(systemName: "checklist"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
        
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
    
    

}

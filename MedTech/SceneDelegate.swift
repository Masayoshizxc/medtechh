//
//  SceneDelegate.swift
//  MedTech
//
//  Created by Eldiiar on 31/5/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
            let userDefaults = UserDefaultsService()
            if userDefaults.didSignedIn() {
                let navBar = UINavigationController(rootViewController: TabBarViewController())
                window.rootViewController = navBar
            } else {
//                let viewController = LoginViewController()
//                let navBar = UINavigationController(rootViewController: viewController)
//                window.rootViewController = navBar
                let viewController = OnboardingViewController()
                let navigationController = UINavigationController(rootViewController: viewController)
                window.rootViewController = navigationController
            }

            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}


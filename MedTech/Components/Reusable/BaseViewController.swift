//
//  BaseViewController.swift
//  MedTech
//
//  Created by Eldiiar on 22/6/22.
//

import UIKit

class BaseViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(named: "Violet")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        AppUtility.lockOrientation(.portrait)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        if #available(iOS 11.0, *) {
            navigationController?.additionalSafeAreaInsets.top = 15
        }
    }
    
}

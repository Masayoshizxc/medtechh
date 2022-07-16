//
//  MoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 8/7/22.
//

import UIKit

class MoreChecklistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    

}

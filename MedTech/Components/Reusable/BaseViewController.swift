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

        AppUtility.lockOrientation(.portrait)
        
        view.backgroundColor = .white
    }
    
}

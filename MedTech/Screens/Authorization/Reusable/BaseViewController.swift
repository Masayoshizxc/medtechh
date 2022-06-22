//
//  BaseViewController.swift
//  MedTech
//
//  Created by Eldiiar on 22/6/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            //UIColor(red: 0.975, green: 0.528, blue: 0.648, alpha: 1.0).cgColor,
            //UIColor(red: 0.967, green: 0.919, blue: 0.685, alpha: 1.0).cgColor
            Colors.peach.color.cgColor,
            Colors.lightYellow.color.cgColor
        ]
        
//        gradient.colors = [
//            UIColor(red: 245/255, green: 185/255, blue: 200/255, alpha: 1).cgColor,
//            UIColor(red: 254/255, green: 247/255, blue: 217/255, alpha: 1).cgColor
//        ]
        return gradient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        AppUtility.lockOrientation(.portrait)
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.willTransition(to: newCollection, with: coordinator)
//        if UIDevice.current.orientation == .portrait {
//            print("Current orientation is portrait")
//        } else {
//            print("Current orientation is landscape")
//        }
//    }
    
//    override open var shouldAutorotate: Bool {
//       return false
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    

}

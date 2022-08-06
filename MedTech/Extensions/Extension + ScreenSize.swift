//
//  Extension + ScreenSize.swift
//  MedTech
//
//  Created by Eldiiar on 5/8/22.
//

import UIKit

extension NSObject {
    @objc var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    @objc var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    func widthComputed(_ value: CGFloat) -> CGFloat {
        screenWidth * value / 390
    }
    
    func heightComputed(_ value: CGFloat) -> CGFloat {
        screenHeight * value / 844
    }
    
    var tabbarHeight: CGFloat {
        UITabBarController().tabBar.frame.height
    }
}

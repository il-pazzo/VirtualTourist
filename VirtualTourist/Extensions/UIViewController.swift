//
//  UIViewController.swift
//  MemeMe2
//
//  Created by Glenn Cole on 7/20/19.
//  Copyright © 2019 Glenn Cole. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // simplify creating view controllers from storyboard id's
    static var storyboardIdentifier: String {
        return String( describing: self )
    }
    
    static func instantiate() -> UIViewController {
        return UIStoryboard.main.instantiateViewController( withIdentifier: self.storyboardIdentifier )
    }
}

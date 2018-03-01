//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 13/02/2018.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

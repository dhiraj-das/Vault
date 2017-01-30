//
//  AppearanceManager.swift
//  Vault
//
//  Created by Dhiraj Das on 1/29/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class AppearanceManager {
    class func setNavigationBarHidden(forViewController viewController: UIViewController, hidden: Bool) -> Void {
        viewController.navigationController?.setNavigationBarHidden(hidden, animated: false)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
    }
}

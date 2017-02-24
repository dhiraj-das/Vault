//
//  LaunchViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 2/24/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class LaunchViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (KeychainHelper.getKey(forKey: "PIN") == nil) {
            if let changePINViewController = storyboard?.instantiateViewController(withIdentifier: "ChangePINViewController") as? ChangePINViewController {
                changePINViewController.backEnabledStatus = false
                changePINViewController.titleText = "Set Password"
                self.pushViewController(changePINViewController, animated: true)
            }
        }
    }
}

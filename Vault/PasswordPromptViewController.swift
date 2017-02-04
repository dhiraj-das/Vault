//
//  PasswordPromptViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 1/27/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class PasswordPromptViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var passwordUIValidation: MyPasswordUIValidation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordUIValidation = MyPasswordUIValidation(in: containerView)
        passwordUIValidation.success = { [weak self] _ in
            print("*️⃣ success!")
            if let homeVC = self?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
        passwordUIValidation.failure = { [weak self] _ in
            print("*️⃣ failure!")
            self?.dismiss(animated: true, completion: nil)
        }
        passwordUIValidation.view.rearrangeForVisualEffectView(in: self)
        passwordUIValidation.view.touchAuthenticationAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//            let alertController = UIAlertController(title: "Vault", message: "We recommend you to enable TouchID for maximum security", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                alertController.dismiss(animated: true, completion: nil)
//            })
//            alertController.addAction(okButton)
//            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

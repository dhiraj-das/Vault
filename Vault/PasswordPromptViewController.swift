//
//  PasswordPromptViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 1/26/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class PasswordPromptViewController: UIViewController {
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kPasswordDigit = 6
        let passwordContainerView = PasswordContainerView.create(in: view, digit: kPasswordDigit)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        let topConst = NSLayoutConstraint(item: passwordContainerView, attribute: .top, relatedBy: .equal, toItem: passwordLabel, attribute: .bottom, multiplier: 1, constant: 30)
        let bottomConst = NSLayoutConstraint(item: passwordContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConst = NSLayoutConstraint(item: passwordContainerView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightConst = NSLayoutConstraint(item: passwordContainerView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let centerXConst = NSLayoutConstraint(item: passwordContainerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        view.addConstraints([topConst, centerXConst, leftConst,rightConst,bottomConst])
        
        passwordContainerView.delegate = self
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.blue
        passwordContainerView.highlightedColor = UIColor.black
    }
}

extension PasswordPromptViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension PasswordPromptViewController {
    func validation(_ input: String) -> Bool {
        return input == "123456"
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        //dismiss(animated: true, completion: nil)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        //passwordContainerView.wrongPassword()
    }
}

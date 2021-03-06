//
//  LoginViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        let reasonString = "Authenticate to access your Vault."
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { (success, error) in
                if success {
                    OperationQueue.main.addOperation({ () -> Void in
                        print("Successful")
                        self.loginSuccessful()
                    })
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(error?.localizedDescription)
                    
//                    switch error!.code {
//                        
//                    case LAError.SystemCancel.rawValue:
//                        print("Authentication was cancelled by the system")
//                        
//                    case LAError.UserCancel.rawValue:
//                        print("Authentication was cancelled by the user")
//                        
//                    case LAError.UserFallback.rawValue:
//                        print("User selected to enter custom password")
//                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                            print("custom password selected")
//                        })
//                        
//                        
//                    default:
//                        print("Authentication failed")
//                        
//                    }
                }
            }
        }
        else{
            // If the security policy cannot be evaluated then show a short message depending on the error.
//            switch error!.code{
//                
//            case LAError.TouchIDNotEnrolled.rawValue:
//                print("TouchID is not enrolled")
//                
//            case LAError.PasscodeNotSet.rawValue:
//                print("A passcode has not been set")
//                
//            default:
//                // The LAError.TouchIDNotAvailable case.
//                print("TouchID not available")
//            }
//            
//            // Optionally the error description can be displayed on the console.
//            print(error?.localizedDescription)
            
            // Show the custom alert view to allow users to enter the password.
            
        }
    }
    
    private func loginSuccessful() {
        if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}


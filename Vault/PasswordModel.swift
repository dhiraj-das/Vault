//
//  PasswordModel.swift
//  Vault
//
//  Created by Dhiraj Das on 1/26/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class MyPasswordModel {
    class func match(_ password: String) -> MyPasswordModel? {
        guard password == "123456" else { return nil }
        return MyPasswordModel()
    }
}

class MyPasswordUIValidation: PasswordUIValidation<MyPasswordModel> {
    init(in containerView: UIView) {
        super.init(in: containerView, digit: 6)
        validation = { password in
            MyPasswordModel.match(password)
        }
    }
    
    //handle Touch ID
    override func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            let dummyModel = MyPasswordModel()
            self.success?(dummyModel)
        } else {
            passwordContainerView.clearInput()
        }
    }
}

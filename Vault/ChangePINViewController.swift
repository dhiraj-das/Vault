//
//  ChangePINViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 2/4/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChangePINViewController: UIViewController {

    @IBOutlet weak var backButton: RoundedCornerButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstPinEntryField: UITextField!
    @IBOutlet weak var secondPinEntryField: UITextField!
    @IBOutlet weak var thirdPinEntryField: UITextField!
    @IBOutlet weak var fourthPinEntryField: UITextField!
    @IBOutlet weak var fifthPinEntryField: UITextField!
    @IBOutlet weak var sixthPinEntryField: UITextField!
    @IBOutlet weak var firstConfirmPinEntryField: UITextField!
    @IBOutlet weak var secondConfirmPinEntryField: UITextField!
    @IBOutlet weak var thirdConfirmPinEntryField: UITextField!
    @IBOutlet weak var fourthConfirmPinEntryField: UITextField!
    @IBOutlet weak var fifthConfirmPinEntryField: UITextField!
    @IBOutlet weak var sixthConfirmPinEntryField: UITextField!
    var titleText: String?
    var backEnabledStatus: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextFieldTextChangeObservers()
        titleLabel.text = titleText ?? "Change Password"
        backButton.isEnabled = backEnabledStatus
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstPinEntryField.becomeFirstResponder()
        firstConfirmPinEntryField.alpha = 0
        secondConfirmPinEntryField.alpha = 0
        thirdConfirmPinEntryField.alpha = 0
        fourthConfirmPinEntryField.alpha = 0
        fifthConfirmPinEntryField.alpha = 0
        sixthConfirmPinEntryField.alpha = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func addTextFieldTextChangeObservers() {
        firstPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        secondPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        thirdPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fourthPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fifthPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        sixthPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        firstConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        secondConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        thirdConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fourthConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fifthConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        sixthConfirmPinEntryField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func textDidChange(textField: UITextField) {
        switch textField {
        case firstPinEntryField:
            secondPinEntryField.becomeFirstResponder()
        case secondPinEntryField:
            thirdPinEntryField.becomeFirstResponder()
        case thirdPinEntryField:
            fourthPinEntryField.becomeFirstResponder()
        case fourthPinEntryField:
            fifthPinEntryField.becomeFirstResponder()
        case fifthPinEntryField:
            sixthPinEntryField.becomeFirstResponder()
        case sixthPinEntryField:
            firstConfirmPinEntryField.alpha = 1
            secondConfirmPinEntryField.alpha = 1
            thirdConfirmPinEntryField.alpha = 1
            fourthConfirmPinEntryField.alpha = 1
            fifthConfirmPinEntryField.alpha = 1
            sixthConfirmPinEntryField.alpha = 1
            firstPinEntryField.alpha = 0
            secondPinEntryField.alpha = 0
            thirdPinEntryField.alpha = 0
            fourthPinEntryField.alpha = 0
            fifthPinEntryField.alpha = 0
            sixthPinEntryField.alpha = 0
            titleLabel.text = "Confirm PIN"
            firstConfirmPinEntryField.becomeFirstResponder()
        case firstConfirmPinEntryField:
            secondConfirmPinEntryField.becomeFirstResponder()
        case secondConfirmPinEntryField:
            thirdConfirmPinEntryField.becomeFirstResponder()
        case thirdConfirmPinEntryField:
            fourthConfirmPinEntryField.becomeFirstResponder()
        case fourthConfirmPinEntryField:
            fifthConfirmPinEntryField.becomeFirstResponder()
        case fifthConfirmPinEntryField:
            sixthConfirmPinEntryField.becomeFirstResponder()
        default:
            self.resignFirstResponder()
            var password: String = ""
            var confirmPassword: String = ""
            if let firstPIN = firstPinEntryField.text,
                let secondPIN = secondPinEntryField.text,
                let thirdPIN = thirdPinEntryField.text,
                let fourthPIN = fourthPinEntryField.text,
                let fifthPIN = fifthPinEntryField.text,
                let sixthPIN = sixthPinEntryField.text,
                let firstPINConfirm = firstConfirmPinEntryField.text,
                let secondPINConfirm = secondConfirmPinEntryField.text,
                let thirdPINConfirm = thirdConfirmPinEntryField.text,
                let fourthPINConfirm = fourthConfirmPinEntryField.text,
                let fifthPINConfirm = fifthConfirmPinEntryField.text,
                let sixthPINConfirm = sixthConfirmPinEntryField.text{
                password = firstPIN+secondPIN+thirdPIN+fourthPIN+fifthPIN+sixthPIN
                confirmPassword = firstPINConfirm+secondPINConfirm+thirdPINConfirm+fourthPINConfirm+fifthPINConfirm+sixthPINConfirm
                if password == confirmPassword && password.characters.count == 6 {
                    let _ = KeychainHelper.setKey(forKey: "PIN", value: password)
                    print("PIN UPDATED SUCCESSFULLY")
                } else {
                    print("PIN UPDATE FAILED")
                }
                let _ = navigationController?.popViewController(animated: true)
            }
        }
    }
}



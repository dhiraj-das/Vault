//
//  EntryViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/25/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import SkyFloatingLabelTextField

class EntryViewController: UIViewController {
    
    @IBOutlet weak var usernameCenterY: NSLayoutConstraint!
    @IBOutlet weak var passwordCenterY: NSLayoutConstraint!
    @IBOutlet weak var additionalDetailsCenterY: NSLayoutConstraint!
    @IBOutlet weak var websiteCenterY: NSLayoutConstraint!
    @IBOutlet weak var website: SkyFloatingLabelTextField!
    @IBOutlet weak var username: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var additionalDetails: SkyFloatingLabelTextField!
    @IBOutlet weak var websiteIcon: UIImageView!
    @IBOutlet weak var maskButton: UIButton!
    
    private var imageData: NSData?
    private var saveButton: UIBarButtonItem!
    private var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        website.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
        username.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
        additionalDetails.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    @IBAction func didPressMaskPassword(_ sender: Any) {
        password.isSecureTextEntry = !password.isSecureTextEntry
    }
    func setupNavBar() {
        let navBar = UINavigationBar()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navItem = UINavigationItem(title: "New Entry")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .normal)
        navItem.leftBarButtonItem = cancelButton
        saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.vaultGrey(), NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .disabled)
        saveButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .normal)
        navItem.rightBarButtonItem = saveButton
        navBar.items = [navItem]
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!]
        view.addSubview(navBar)
        let leftConstraint = NSLayoutConstraint(item: navBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: navBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: navBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 20)
        view.addConstraints([leftConstraint, rightConstraint, topConstraint])
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savePressed() {
//        if validateFields() {
//            let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
//            let realm = try! Realm(configuration: configuration)
//            try! realm.write {
//                let obj = Entry(website: website.text!, username: username.text!, password: password.text!, details: additionalDetails.text!, imageData: imageData)
//                realm.add(obj)
//            }
//            dismiss(animated: true, completion: nil)
//        }
        
        if validateFields() {
            let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
            var realm: Realm?
            do {
                realm = try Realm(configuration: configuration)
            } catch let error as NSError {
                print("COULD NOT OPEN REALM")
                print(error.debugDescription)
                dismiss(animated: true, completion: nil)
                return
            }
            if let realm = realm {
                do {
                    let _ = try realm.write {
                        let record = Entry(website: website.text!, username: username.text!, password: password.text!, details: additionalDetails.text, imageData: imageData)
                        realm.add(record)
                    }
                } catch let error as NSError {
                    print("COULD NOT WRITE TO REALM")
                    print(error.debugDescription)
                    dismiss(animated: true, completion: nil)
                    return
                }
                dismiss(animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Vault", message: "Please complete the fields before saving", preferredStyle: .alert)
            let dismissButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(dismissButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func textFieldChanged(sender: UITextField) {
        switch sender {
        case website:
            if (sender.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
                websiteCenterY.constant = -5
            } else {
                websiteCenterY.constant = 2
            }
        case password:
            if (sender.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
                passwordCenterY.constant = -5
            } else {
                passwordCenterY.constant = 2
            }
        case username:
            if (sender.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
                usernameCenterY.constant = -5
            } else {
                usernameCenterY.constant = 2
            }
        default:
            break
        }
    }
    
    func fetchIcon(url website: String) {
        let URL = NSURL(string: "https://logo.clearbit.com/\(website)")
        if let url = URL {
            let session = URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in
                if error == nil {
                    self.imageData = data as NSData?
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.websiteIcon.image = image
                        self.websiteIcon.layer.cornerRadius = 5
                    }
                }
            })
            session.resume()
        }
    }
}

extension EntryViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == website {
            if textField.text != nil && textField.text != "" {
                fetchIcon(url: textField.text!)
            } else {
                DispatchQueue.main.async { self.websiteIcon.image = nil }
            }
        }
    }
    
    func validateFields() -> Bool{
        guard let websiteText = website.text, websiteText != "" else{
            return false
        }
        guard let usernameText = username.text, usernameText != "" else{
            return false
        }
        guard let passwordText = password.text, passwordText != "" else{
            return false
        }
        return true
    }
}



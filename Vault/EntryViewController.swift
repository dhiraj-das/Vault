//
//  EntryViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/25/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import Foundation
import RealmSwift
import Security
import UIKit
import SwiftKeychainWrapper
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func setupNavBar() {
        let navBar = UINavigationBar()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "New Entry")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .normal)
        navItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
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
        dismiss(animated: true, completion: nil)
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
        case additionalDetails:
            if (sender.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
                additionalDetailsCenterY.constant = -5
            } else {
                additionalDetailsCenterY.constant = 2
            }
        default:
            if (sender.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
                usernameCenterY.constant = -5
            } else {
                usernameCenterY.constant = 2
            }
        }
    }
}

//// Model definition
//class EncryptionObject: Object {
//    dynamic var stringProp = ""
//}
//let textView = UITextView(frame: UIScreen.main.applicationFrame)
//override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    
//    // Use an autorelease pool to close the Realm at the end of the block, so
//    // that we can try to reopen it with different keys
//    autoreleasepool {
//        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//        let realm = try! Realm(configuration: configuration)
//        
//        // Add an object
//        try! realm.write {
//            let obj = EncryptionObject()
//            obj.stringProp = "abcd"
//            realm.add(obj)
//        }
//    }
//    
//    // Opening with wrong key fails since it decrypts to the wrong thing
//    autoreleasepool {
//        do {
//            let configuration = Realm.Configuration(encryptionKey: "1234567890123456789012345678901234567890123456789012345678901233".data(using: String.Encoding.utf8, allowLossyConversion: false))
//            _ = try Realm(configuration: configuration)
//        } catch {
//            log(text: "Open with wrong key: \(error)")
//        }
//    }
//    
//    // Opening wihout supplying a key at all fails
//    autoreleasepool {
//        do {
//            _ = try Realm()
//        } catch {
//            log(text: "Open with no key: \(error)")
//        }
//    }
//    
//    // Reopening with the correct key works and can read the data
//    autoreleasepool {
//        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//        let realm = try! Realm(configuration: configuration)
//        if let stringProp = realm.objects(EncryptionObject.self).first?.stringProp {
//            log(text: "Saved object: \(stringProp)")
//        }
//    }
//}
//
//func log(text: String) {
//    textView.text = textView.text + text + "\n\n"
//}
//
//func getKey() -> Data {
//    
//    if let key = KeychainWrapper.standard.data(forKey: "someid") {
//        return key
//    } else {
//        var key = Data(count: 64)
//        _ = key.withUnsafeMutableBytes { bytes in
//            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
//        }
//        KeychainWrapper.standard.set(key, forKey: "someid")
//        return key as Data
//    }
//}
//}

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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var website: SkyFloatingLabelTextField!
    @IBOutlet weak var username: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var additionalDetails: SkyFloatingLabelTextField!
    @IBOutlet weak var websiteIcon: UIImageView!
    @IBOutlet weak var maskButton: UIButton!
    
    private var imageData: NSData?
    private var saveButton: UIBarButtonItem!
    private var navItem: UINavigationItem!
    var indicator: UIActivityIndicatorView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = website.becomeFirstResponder()
    }
    
    @IBAction func didPressMaskPassword(_ sender: Any) {
        password.isSecureTextEntry = !password.isSecureTextEntry
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        view.endEditing(true)
        if validateFields() {
            let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKeyForRealm())
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
    
    func fetchIcon(url website: String) {
        let URL = NSURL(string: "https://logo.clearbit.com/\(website)")
        if let url = URL {
            let session = URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in
                if error == nil {
                    self.imageData = data as NSData?
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.websiteIcon.image = image
                            self.websiteIcon.layer.cornerRadius = 5
                        }
                    }
                    self.indicator.stopAnimating()
                    self.indicator.removeFromSuperview()
                } else {
                    DispatchQueue.main.async { self.websiteIcon.image = UIImage(named: "website-icon-29479") }
                    self.indicator.stopAnimating()
                    self.indicator.removeFromSuperview()
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
                indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                indicator.center = CGPoint(x: websiteIcon.frame.width/2, y: websiteIcon.frame.height/2)
                indicator.startAnimating()
                websiteIcon.addSubview(indicator)
                fetchIcon(url: textField.text!)
            } else {
                DispatchQueue.main.async { self.websiteIcon.image = UIImage(named: "website-icon-29479") }
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



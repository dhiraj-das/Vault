//
//  DetailViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/19/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var additionalDetailsLabel: UILabel!
    var website: String!
    var password: String!
    var username: String!
    var details: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeCardView()
        customizeNavBar()
        loadDetails()
    }
    
    func customizeCardView() {
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardView.layer.shadowOpacity = 0.7
    }
    
    func customizeNavBar() {
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backPressed))
        back.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!], for: .normal)
        navigationItem.setLeftBarButton(back, animated: true)
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPressed))
        edit.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!], for: .normal)
        navigationItem.setRightBarButton(edit, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func editPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func loadDetails() {
        titleLabel.text = website
        passwordLabel.text = password
        usernameLabel.text = username
        additionalDetailsLabel.text = details
    }

}

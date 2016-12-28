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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeCardView()
        customizeNavBar()
    }
    
    func customizeCardView() {
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardView.layer.shadowOpacity = 0.7
    }
    
    func customizeNavBar() {
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        back.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18.0)!], for: UIControlState.normal)
        back.tintColor = UIColor.black
        navigationItem.setLeftBarButtonItems([back], animated: true)
    }
    
    func backPressed() {
        navigationController?.popViewController(animated: true)
    }

}

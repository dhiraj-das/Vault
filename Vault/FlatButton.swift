//
//  FlatButton.swift
//  Vault
//
//  Created by Dhiraj Das on 12/18/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import Foundation
import UIKit

class FlatButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
    
    private func setupAppearance() {
        backgroundColor = UIColor(red: 200/255, green: 64/255, blue: 128/255, alpha: 1)
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        //layer.shadowRadius = 10.0
        titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        setTitleColor(UIColor.white, for: .normal)
    }
    
}

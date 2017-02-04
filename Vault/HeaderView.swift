//
//  HeaderView.swift
//  Vault
//
//  Created by Dhiraj Das on 2/2/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.textLabel?.textColor = UIColor.textDarkGrey()
        self.tintColor = UIColor.backgroundDark()
        self.textLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        self.textLabel?.textAlignment = NSTextAlignment.left
    }
}

//
//  SettingsTableViewCell.swift
//  Vault
//
//  Created by Dhiraj Das on 2/2/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    var toggleSwitch = UISwitch()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.accessoryView = toggleSwitch
        toggleSwitch.addTarget(self, action: #selector(updateSwitchAtIndexPath(sender:)), for: UIControlEvents.touchUpInside)
        self.backgroundColor = UIColor.navigationBar()
        self.textLabel?.textColor = UIColor.textLightGrey()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    @objc func updateSwitchAtIndexPath(sender: UISwitch) {
        print(sender.isOn)
    }
}

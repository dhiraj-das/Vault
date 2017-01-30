//
//  SettingsViewControllerEnums.swift
//  Vault
//
//  Created by Dhiraj Das on 1/26/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import Foundation

enum SettingsSections: Int {
    case general, about
    case count
}

enum GeneralSection: Int {
    case changePassword, enableTouchID
    case count
}

enum AboutSection: Int {
    case about
    case count
}

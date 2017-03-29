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

enum AboutSection: Int, CustomStringConvertible {
    case about
    case count
    
    var description: String {
        switch self {
        case .about:
            return "© 2017 Dhiraj Das.\nMade with ❤️"
        default:
            return ""
        }
    }
}

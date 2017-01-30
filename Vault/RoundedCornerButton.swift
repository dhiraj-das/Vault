//
//  RoundedCornerButton.swift
//  Vault
//
//  Created by Dhiraj Das on 1/21/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedCornerButton: UIButton {
    
    @IBInspectable
    var cornerRadius: Int = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
}

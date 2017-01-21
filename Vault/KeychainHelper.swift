//
//  KeychainHelper.swift
//  Vault
//
//  Created by Dhiraj Das on 12/30/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import SwiftKeychainWrapper

class KeychainHelper {
    public static func getKey() -> Data {
        if let key = KeychainWrapper.standard.data(forKey: "someid") {
            return key
        } else {
            var key = Data(count: 64)
            _ = key.withUnsafeMutableBytes { bytes in
                SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
            }
            KeychainWrapper.standard.set(key, forKey: "someid")
            return key as Data
        }
    }
}

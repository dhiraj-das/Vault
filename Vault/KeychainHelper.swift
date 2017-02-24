//
//  KeychainHelper.swift
//  Vault
//
//  Created by Dhiraj Das on 12/30/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import SwiftKeychainWrapper

class KeychainHelper {
    public static func getKeyForRealm() -> Data {
        if let key = KeychainWrapper.standard.data(forKey: "vault_decryption_key") {
            return key
        } else {
            var key = Data(count: 64)
            _ = key.withUnsafeMutableBytes { bytes in
                SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
            }
            KeychainWrapper.standard.set(key, forKey: "vault_decryption_key")
            return key as Data
        }
    }
    
    public static func getKey(forKey key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    public static func setKey(forKey key: String, value: String) -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key)
    }
}

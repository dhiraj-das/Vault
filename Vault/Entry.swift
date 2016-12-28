//
//  Entry.swift
//  Vault
//
//  Created by Dhiraj Das on 12/23/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import RealmSwift
import Realm

class Entry: Object{
    dynamic var title: String = ""
    dynamic var email: String = ""
    dynamic var password: String = ""
    dynamic var details: String = ""
    
    convenience init(title: String, email: String, password: String, details: String?) {
        self.init()
        self.title = title
        self.email = email
        self.password = password
        if let details = details {
            self.details = details
        }
    }
    
    override class func indexedProperties() -> [String] {
        return ["title"]
    }
}

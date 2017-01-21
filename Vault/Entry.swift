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
    dynamic var website: String = ""
    dynamic var username: String = ""
    dynamic var password: String = ""
    dynamic var details: String = ""
    dynamic var imageData: NSData = NSData()
    
    convenience init(website: String, username: String, password: String, details: String?, imageData: NSData?) {
        self.init()
        self.website = website
        self.username = username
        self.password = password
        if let details = details {
            self.details = details
        }
        if let imageData = imageData {
            self.imageData = imageData
        }
    }
    
    override class func indexedProperties() -> [String] {
        return ["title"]
    }
}

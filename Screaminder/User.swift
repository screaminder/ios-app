//
//  User.swift
//  Screaminder
//
//  Created by Anton Narusberg on 10/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {

    var phone: String?
    var key: String?
    var verified: Bool?

    init(phone: String, key: String, verified: Bool) {
        self.phone = phone
        self.key = key
        self.verified = verified
    }

    required init?(coder aDecoder: NSCoder) {
        phone = aDecoder.decodeObjectForKey("phone") as? String
        key = aDecoder.decodeObjectForKey("key") as? String
        verified = aDecoder.decodeBoolForKey("verified")

        super.init()
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(phone, forKey: "phone")
        aCoder.encodeObject(key, forKey: "key")
        aCoder.encodeBool(verified!, forKey: "verified")
    }

}
//
//  UserSessionStore.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation

class TokenStore {

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("token")

    static func save(token: String) {
        NSKeyedArchiver.archiveRootObject(token, toFile: ArchiveURL.path!)
    }

    static func read() -> String? {
        if let user = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? String {
            return user
        }
        return nil
    }

    static func clear() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(ArchiveURL.path!)
        } catch {
        }
    }

}
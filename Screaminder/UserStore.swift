//
//  UserSessionStore.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation

class UserStore {

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("user_store")

    static func save(token: User) {
        NSKeyedArchiver.archiveRootObject(token, toFile: ArchiveURL.path!)
    }

    static func read() -> User? {
        if let user = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? User {
            return user
        }
        return nil
    }

    static func readBearer() -> String? {
        if let user = read() {
            return user.key
        }
        return ""
    }

    static func clear() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(ArchiveURL.path!)
        } catch {
        }
    }

}
//
//  Todo.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import SwiftDate

class Todo {

    var id: String
    var type: String
    var title: String
    var datetime: NSDate
    var done: Bool
    var editable: Bool

    var inFuture: Bool {
        return datetime.isAfter(.Second, ofDate: NSDate())
    }

    var time: String {
        if datetime.isInTomorrow() {
            return "TOMORROW"
        } else if datetime.isInToday() {
            return "SOON"
        } else if datetime.isBefore(.Day, ofDate: NSDate()) {
            return "PAST"
        }

        return "SOMETIME IN THE FUTURE"
    }

    init(id: String, type: String, title: String, datetime: String, done: Bool, editable: Bool) {
        self.id = id
        self.type = type
        self.title = title
        self.done = done
        self.editable = editable

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000'Z'"
        self.datetime = dateFormatter.dateFromString(datetime)!
    }
    
}

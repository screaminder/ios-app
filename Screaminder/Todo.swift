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

    static let dateformat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

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
        if datetime.isBefore(.Minute, ofDate: NSDate() + 12.hours) {
            return "soon, you motherfucker"
        } else if datetime.isInToday() {
            return "today or so"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 1.weeks) {
            return "less than 1 week"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 2.weeks) {
            return "in a few weeks probably"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 3.weeks) {
            return "in three weeks probably"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 1.months) {
            return "in a month"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 3.months) {
            return "in a couple of months"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 6.months) {
            return "in half a year"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 1.years) {
            return "in an epic year"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 2.years) {
            return "in two fucking years"
        } else if datetime.isBefore(.Minute, ofDate: NSDate() + 3.years) {
            return "in three fucking years"
        }

        return "far in the future"
    }

    init(id: String, type: String, title: String, datetime: String, done: Bool, editable: Bool) {
        self.id = id
        self.type = type
        self.title = title
        self.done = done
        self.editable = editable

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = Todo.dateformat
        self.datetime = dateFormatter.dateFromString(datetime)!
    }
    
}

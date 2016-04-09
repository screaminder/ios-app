//
//  Todo.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation

class Todo {

    var id: String
    var type: String
    var title: String
    var datetime: Int

    var time: String {
        return "SOON"
    }

    init(id: String, type: String, title: String, datetime: Int) {
        self.id = id
        self.type = type
        self.title = title
        self.datetime = datetime
    }

}

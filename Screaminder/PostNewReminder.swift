//
//  PostNewReminder.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import Alamofire

class PostNewReminder {

    var completion: ((Bool) -> ())

    var type: String
    var title: String
    var datetime: String

    init(type: String, title: String, datetime: NSDate, completion: ((Bool) -> ())) {
        self.completion = completion

        self.type = type
        self.title = title

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = Todo.dateformat

        self.datetime = dateFormatter.stringFromDate(datetime)
    }

    func start() {
        let params = ["type": self.type, "title": self.title, "datetime": self.datetime]

        Alamofire.request(.POST, "https://screaminder-api.herokuapp.com/items",
            parameters: params,
            encoding: .JSON,
            headers: ["Authorization": "Bearer \(UserStore.readBearer()!)"])
            .responseJSON { response in
                if let _ = response.result.value {
                    self.completion(true)
                } else {
                    self.completion(false)
                }
        }
    }

}

//
//  GetReminders.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import Alamofire

class GetReminders {

    var completion: (([Todo]) -> ())

    init(completion: (([Todo]) -> ())) {
        self.completion = completion
    }

    func start() {
        Alamofire.request(.GET, "https://screaminder-api.herokuapp.com/items",
            parameters: [:],
            encoding: .JSON,
            headers: ["Authorization": "Bearer \(TokenStore.read()!)"])
            .responseJSON { response in
                if let array = response.result.value as? [[String: AnyObject]] {
                    var todos: [Todo] = []

                    for item in array.reverse() {
                        guard let id = item["_id"] as? String,
                            type = item["type"] as? String,
                            title = item["title"] as? String,
                            datetime = item["datetime"] as? String,
                            done = item["done"] as? Bool,
                            editable = item["editable"] as? Bool
                            else {
                                continue
                        }

                        let todo = Todo(id: id, type: type, title: title, datetime: datetime, done: done, editable: editable)
                        if todo.inFuture || todo.editable {
                            todos.append(todo)
                        }
                    }

                    self.completion(todos)
                } else {
                    self.completion([])
                }
        }
    }
    
}

//
//  PutMarkAsDone.swift
//  Screaminder
//
//  Created by Anton Narusberg on 10/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import Alamofire

class PutMarkAsDone {

    var completion: ((Bool) -> ())

    var id: String

    init(id: String, completion: ((Bool) -> ())) {
        self.completion = completion

        self.id = id
    }

    func start() {
        let params = ["done": true]

        Alamofire.request(.POST, "https://screaminder-api.herokuapp.com/items/\(self.id)",
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

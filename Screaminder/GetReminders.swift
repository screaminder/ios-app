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
            encoding: .JSON, headers: ["Authorization": "Bearer \(TokenStore.read())"])
            .responseJSON { response in
                if let json = response.result.value {
                }
        }
    }
    
}

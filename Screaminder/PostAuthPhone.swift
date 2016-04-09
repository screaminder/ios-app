//
//  PostAuthPhone.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import Alamofire

class PostAuthPhone {

    var number: String?

    init(number: String) {
        self.number = number
    }

    // "Authorization": "Bearer \(TokenStore.read())"
    func start() {
        Alamofire.request(.POST, "https://screaminder-api.herokuapp.com/auth", parameters: ["phone": self.number!], encoding: .JSON, headers: [:]).responseJSON { response in
            if let json = response.result.value, token = json["key"] as? String {
                TokenStore.save(token )
            }
        }
    }

}

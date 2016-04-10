//
//  PostVerificationCode.swift
//  Screaminder
//
//  Created by Anton Narusberg on 10/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import Foundation
import Alamofire

class PostVerificationCode {

    var completion: ((Bool) -> ())

    var code: String

    init(code: String, completion: ((Bool) -> ())) {
        self.completion = completion
        self.code = code
    }

    func start() {
        var params: [String: AnyObject] = [:]

        if let code = Int(self.code) {
            params = ["code": code]
        } else {
            completion(false)
        }

        Alamofire.request(.POST, "https://screaminder-api.herokuapp.com/verify",
            parameters: params,
            encoding: .JSON,
            headers: ["Authorization": "Bearer \(UserStore.readBearer()!)"])
            .responseJSON { response in
                if let json = response.result.value,
                    phone = json["phone"] as? String,
                    key = json["key"] as? String,
                    verified = json["verified"] as? Bool {

                    UserStore.save(User(phone: phone, key: key, verified: verified))

                    self.completion(true)
                } else {
                    self.completion(false)
                }
        }
    }


}

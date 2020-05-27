//
//  LoginHandler.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import Combine
import Alamofire
import SwiftKeychainWrapper

class LoginHandler: APIHandler {
    
    @Published var authenticated = false
    @Published var isLoading = false
            
    func tryLogin(email :String , password :String) {
        let body: [String: String] = [
            "email" : email,
            "password" : password,
        ]
        AF.request("https://corntinental.herokuapp.com/api/auth/login", method: .post,  parameters: body, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        if(json["access_token"] != nil){
                            let success: Bool = KeychainWrapper.standard.set(json["access_token"] as! String, forKey: "accessToken")
                            self.authenticated = success
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}

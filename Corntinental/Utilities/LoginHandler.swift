//
//  LoginHandler.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import Combine
import Alamofire
import KeychainStorage

class LoginHandler: APIHandler {
    
    @Published var woofResponse: WoofResponse?
    @Published var isLoading = false
            
    func getRandomDog() {
        isLoading = true
        
        let url = "https://random.dog/woof.json"
        
        AF.request(url, method: .get).responseDecodable { [weak self] (response: DataResponse<WoofResponse, AFError>) in
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? WoofResponse else {
                weakSelf.isLoading = false
                return
            }
                            
            weakSelf.isLoading = false
            weakSelf.woofResponse = response
        }
    }
}

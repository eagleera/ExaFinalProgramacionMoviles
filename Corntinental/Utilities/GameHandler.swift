//
//  GameHandler.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 27/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import UIKit

import Combine
import Alamofire
import SwiftKeychainWrapper

class GameHandler: APIHandler {
    @Published var recordResponse: RecordResponse?
    @Published var name: String = ""
    @Published var records: [Record] = []

    func getRecord() {
        let url = "https://corntinental.herokuapp.com/api/record"
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken ?? "")]
        AF.request(url, method: .get, headers: headers).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let record = try decoder.decode(RecordResponse.self, from: data)
                self.recordResponse = record
                self.records = record.record
                self.name = record.user?.name ?? ""
            } catch let error {
                print(error)
            }
        }
    }
}

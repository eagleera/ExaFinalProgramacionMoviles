//
//  WoofResponse.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

class WoofResponse: Decodable {
    
    var fileSizeBytes: Int?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case fileSizeBytes
        case url
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        fileSizeBytes = try? container.decode(Int.self, forKey: .fileSizeBytes)
        url = try? container.decode(String.self, forKey: .url)
    }
}

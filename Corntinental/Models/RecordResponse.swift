//
//  RecordResponse.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 27/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

struct RecordResponse: Codable {
    let user: User?
    let record: [Record]
    
    private enum CodingKeys: String, CodingKey {
        case user
        case record
    }
}

struct User : Codable {
    let admin : Bool
    let email : String
    let name : String
    let id : Int
}

struct Record : Codable {
    let id: Int
    let alias : String
    let points : Int
    let place : Int
    let won : Int
    let room: Room?
    private enum CodingKeys: String, CodingKey {
        case id = "guest_id"
        case alias
        case points
        case place
        case won
        case room
    }
}
struct Room : Codable {
    let name : String
}


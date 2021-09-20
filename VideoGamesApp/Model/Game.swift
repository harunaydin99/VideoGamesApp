//
//  Game.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 17.09.2021.
//

import Foundation
struct Game: Codable, Equatable {
    
    let backgroundImage: String?
    let id: Int?
    let released: String?
    let rating: Double?
    let name: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, released, rating, name
        case backgroundImage = "background_image"
    }
    
}

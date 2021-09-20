//
//  Detail.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 19.09.2021.
//

import Foundation
struct Detail: Codable {
    
    let backgroundImage: String?
    let name: String?
    let released: String?
    let description: String?
    let metacritic: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case name, released, metacritic
        case backgroundImage = "background_image"
        case description = "description_raw"
    }
    
}

//
//  GameNetwork.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 17.09.2021.
//

import Foundation
class GameNetwork {
    
    static let shared = GameNetwork()
    
    func getGames(page: Int,completion: @escaping (Result<GameResult, Error>) -> Void) {
        var tempUrl = "https://api.rawg.io/api/games?key=31a3b8ccca224ea799b4552e8453a789&page="
       /* if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            tempUrl = NetworkConstants.trGetPopularMoviesUrl
        }*/
       // var request = URLRequest(url: URL(string: NetworkConstants.getPopularMoviesURL+"\(id)")!)
        var request = URLRequest(url: URL(string: tempUrl+"\(page)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(GameResult.self, from: data)
                    completion(.success(result))
                    // print(result)
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(RMError.customError))
                }
            }
        }
        dataTask.resume()
        
    }
}

enum RMError: Error {
    case customError
}

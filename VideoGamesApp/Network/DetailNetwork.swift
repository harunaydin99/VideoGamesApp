//
//  DetailNetwork.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 19.09.2021.
//

import Foundation
class DetailNetwork {
    
    static let shared = DetailNetwork()
    
    func getDetail(id: Int,completion: @escaping (Result<Detail, Error>) -> Void) {
        var tempUrl = "https://api.rawg.io/api/games/\(id)?key=31a3b8ccca224ea799b4552e8453a789"
       /* if String(Locale.preferredLanguages[0].prefix(2)) == "tr" {
            tempUrl = NetworkConstants.trGetPopularMoviesUrl
        }*/
       // var request = URLRequest(url: URL(string: NetworkConstants.getPopularMoviesURL+"\(id)")!)
        var request = URLRequest(url: URL(string: tempUrl)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Detail.self, from: data)
                    completion(.success(result))
                    // print(result)
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(DetailError.customError))
                }
            }
        }
        dataTask.resume()
        
    }
}

enum DetailError: Error {
    case customError
}

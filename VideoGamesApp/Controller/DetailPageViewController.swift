//
//  DetailPageViewController.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 19.09.2021.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var selectedGame: Game?
    var selectedGameId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = selectedGameId {
            getGameDetails(id: id)
        }
        // Do any additional setup after loading the view.
    }
    
    func getGameDetails(id: Int) {
        
        DetailNetwork.shared.getDetail(id: id) {  response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let result):
                       /* if let results = result {
                            print(results.genres)
                         }*/
                        if result != nil {
                           // print(result)
                            self.showDetails(result: result)
                        }
                    case .failure(let error):
                       print(error)
                    }
                }
           }
    }
    
    func showDetails(result: Detail) {
       // print(casts)
        gameNameLabel.text = result.name
        releaseDateLabel.text = result.released
        descriptionLabel.text = result.description
        if let vote = result.metacritic {
            metacriticLabel.text = String(vote)
        }
        if let tempString = result.backgroundImage {
             let url = URL(string: tempString)
             gameImageView.kf.setImage(with: url)
        }
        
    }
    
   

}

//
//  GameTableViewCell.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 17.09.2021.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gameReleasedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(game : Game) {
        
        gameNameLabel.text = game.name
        if let vote = game.rating {
            gameRatingLabel.text = String(format: "%.1f", vote)
        } else {
            gameRatingLabel.text = "-"
        }
        gameReleasedLabel.text = game.released
        if let path = game.backgroundImage {
        
            gameImageView.image = UIImage(named: "placeholder")
            let url = URL(string: path)
            gameImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            gameImageView.image = UIImage(named: "placeholder")
        }
        
        
        
        
    }
    
}

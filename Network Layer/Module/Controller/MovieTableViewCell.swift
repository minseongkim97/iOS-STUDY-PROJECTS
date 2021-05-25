//
//  MovieTableViewCell.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var titleNPubdate: UILabel!
    @IBOutlet private weak var rate: UILabel!
    @IBOutlet private weak var director: UILabel!
    @IBOutlet private weak var actors: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(poster: UIImage?, titleNPubdate: String, rate: String, director: String, actors: String) {
        
        self.moviePoster.image = poster
        self.titleNPubdate.text = titleNPubdate
        self.rate.text = rate
        self.director.text = director
        self.actors.text = actors
    }
    
    static func nib() -> UINib? {
        UINib(nibName: identifier, bundle: nil)
    }
    
}

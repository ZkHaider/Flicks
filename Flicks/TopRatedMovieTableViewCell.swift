//
//  TopRatedMovieTableViewCell.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class TopRatedMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setMovie(movie: Movie) {
        
        if movie.backdropPath != nil {
            if let backdropPath = movie.backdropPath {
                posterImage.setImageFromURLString(urlString: backdropPath)
            }
        }
        
        if movie.title != nil {
            if let name = movie.title {
                movieName.text = name
            }
        }
        
        if movie.overview != nil {
            if let description = movie.overview {
                movieDescription.text = description
            }
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

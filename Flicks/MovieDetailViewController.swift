//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    /***********************************
     * Views
     ***********************************/
    
    @IBOutlet weak var backdropImage: UIImageView!
    
    /***********************************
     * Variables
     ***********************************/
    
    var movie: Movie!
    
    /***********************************
     * LifeCycle Methods
     ***********************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Go ahead and load image
        if movie.posterPath != nil {
            if let backdropPath = movie.posterPath {
                backdropImage.setImageFromURLString(urlString: backdropPath)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

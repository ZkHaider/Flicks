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
    @IBOutlet weak var overviewScroll: UIScrollView!
    
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
        
        // Add a corner radius to scrollview
        self.overviewScroll.layer.cornerRadius = 2
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        overviewScroll.addSubview(blurEffectView)
    }
    
    override func viewDidLayoutSubviews() {
        // Set offset to scrollview from top
        self.overviewScroll.setContentOffset(CGPoint(x: 0, y: -350), animated: true)
        self.overviewScroll.layoutIfNeeded()
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

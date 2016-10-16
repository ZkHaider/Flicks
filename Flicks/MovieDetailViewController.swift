//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    
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
        self.overviewScroll.layer.cornerRadius = 4
        
        // Set the scroll view delegate on the scrollview
        overviewScroll.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = overviewScroll.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        overviewScroll.sendSubview(toBack: blurEffectView)
        
        // Set offset to scrollview from top
        self.overviewScroll.setContentOffset(CGPoint(x: 0, y: -350), animated: true)
        self.overviewScroll.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***********************************
     * ScrollView Methods
     ***********************************/

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("began dragging")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let percentage = offsetY / scrollView.contentSize.height
        
        print("Percentage: " + String(describing: percentage))
    }

}

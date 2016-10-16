//
//  UIImageView.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

let imagePrefix = "https://image.tmdb.org/t/p/w500"

extension UIImageView {
    
    public func setImageFromURLString(urlString: String) {
        
        self.alpha = 0.0
        
        // Build URL String
        let requestString = imagePrefix.appending(urlString)
        self.loadImage(url: URL(string: requestString)!, placeholderImage: nil, completion: { (bool, error) in
            
            if error != nil {
                return
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1.0
            })
        })
    }
    
}

//
//  MovieAPI.swift
//  Flicks
//
//  Created by Haider Khan on 10/15/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

let baseUrl = "https://api.themoviedb.org/3"
let apiKey = "7d006fc1373420c29ede8c47fb8163c3"

struct MovieAPI {
    
    // Get the now playing movies from the API
    static func getNowPlayingMovies(completion: @escaping (_ nowPlaying: NowPlaying) -> Void) {
     
        // Form the url
        let requestString = baseUrl.appending("/movie/now_playing").appending("?api_key=").appending(apiKey)
        
        // Go ahead and make the request
        var request = URLRequest(url: URL(string: requestString)!)
        request.httpMethod = "GET"
        let session = URLSession.shared

        session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
            
            if let data = dataOrNil {
                if let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    // Go ahead and create our top rated object from Mapper
                    if let nowPlaying = NowPlaying.from(dictionary) {
                        
                        // Pass to completion block
                        completion(nowPlaying)
                    }
                    
                    
                }
            }
        }).resume()
    }
    
    // Get the top rated movies from the API
    static func getTopRatedMovies(completion: @escaping (_ topRated: TopRated) -> Void) {
        
        // Form the url 
        let requestString = baseUrl.appending("/movie/top_rated").appending("?api_key=").appending(apiKey)
        
        // Go ahead and make the request
        var request = URLRequest(url: URL(string: requestString)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
            
            if let data = dataOrNil {
                if let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    // Go ahead and create our top rated object from Mapper
                    if let topRated = TopRated.from(dictionary) {
                                                
                        // Pass to completion block
                        completion(topRated)
                    }
                    
                    
                }
            }
        }).resume()
    }
    
}

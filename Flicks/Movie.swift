//
//  Movie.swift
//  Flicks
//
//  Created by Haider Khan on 10/15/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct Movie: Mappable {
    
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let id: Int
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    
    // Initializer 
    init(map: Mapper) throws {
        posterPath              = map.optionalFrom("poster_path")
        adult                   = map.optionalFrom("adult")
        overview                = map.optionalFrom("overview")
        releaseDate             = map.optionalFrom("release_date")
        genreIds                = map.optionalFrom("genre_ids")
        try id                  = map.from("id")
        originalTitle           = map.optionalFrom("original_title")
        originalLanguage        = map.optionalFrom("original_language")
        title                   = map.optionalFrom("title")
        backdropPath            = map.optionalFrom("backdrop_path")
        popularity              = map.optionalFrom("popularity")
        voteCount               = map.optionalFrom("vote_count")
        video                   = map.optionalFrom("video")
        voteAverage             = map.optionalFrom("vote_average")
    }
    
}

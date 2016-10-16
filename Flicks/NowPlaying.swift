//
//  NowPlaying.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct NowPlaying: Mappable {
    
    let page: Int
    let results: [Movie]
    let dates: Dates
    let totalResults: Int
    let totalPages: Int
    
    init(map: Mapper) throws {
        try page            = map.from("page")
        results             = map.optionalFrom("results") ?? []
        try dates           = map.from("dates")
        try totalResults    = map.from("total_results")
        try totalPages      = map.from("total_pages")
    }

    
}

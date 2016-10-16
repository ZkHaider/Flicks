//
//  TopRated.swift
//  Flicks
//
//  Created by Haider Khan on 10/15/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct TopRated: Mappable {
    
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
    
    init(map: Mapper) throws {
        try page            = map.from("page")
        results             = map.optionalFrom("results") ?? []
        try totalResults    = map.from("total_results")
        try totalPages      = map.from("total_pages")
    }
    
}

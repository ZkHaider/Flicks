//
//  Dates.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct Dates: Mappable {
    
    let maximum: String
    let minimum: String
    
    init(map: Mapper) throws {
        try maximum = map.from("maximum")
        try minimum = map.from("minimum")
    }
    
}

//
//  Set.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 16/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import Foundation

struct MTGSets: Codable, Equatable {
    var sets: [MTGSet]
}

struct MTGSet: Codable, Equatable {
    var set: MTGSetDetails
}

struct MTGSetDetails: Codable, Equatable {
    var code: String?
    var name: String?
    var type: String
    var block: String?
    var releaseDate: String
}

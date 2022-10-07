//
//  ErrorObject.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation

class ErrorObject: Codable {
    var error: String?
    var response: ErrorObject?
    
    init(message: String) {
        self.error = message
    }
}

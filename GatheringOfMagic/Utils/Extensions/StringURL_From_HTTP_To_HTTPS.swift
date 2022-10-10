//
//  StringURL_From_HTTP_To_HTTPS.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 06/10/22.
//

import Foundation

extension String {
    func protocolAPS() -> String {
        if (self.count > 4) {
            var newStr = self
            let char: Character = "s"
            let strIndex = self.index(self.startIndex, offsetBy: 4)
            newStr.insert(char, at: strIndex)
            return newStr
        } else {
            return self
        }
        
    }
}

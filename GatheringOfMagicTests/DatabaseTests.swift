//
//  DatabaseTests.swift
//  GatheringOfMagicTests
//
//  Created by Eduardo Oliveira on 18/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import XCTest

@testable import GatheringOfMagic

class DatabaseTests: XCTestCase {
    var database: Database!
    
    override func setUp() {
        database = Database()
        super.setUp()
    }
    
    override func tearDown() {
        database = nil
        super.tearDown()
    }
    
    func test_Database_loadData () {
        XCTAssertNoThrow(database.loadData(from: .favoriteCards))
    }
    
    func test_Database_saveData () {
        let array: [Card] = []
        XCTAssertNoThrow(database.saveData(from: array, to: .favoriteCards))
    }
    
    func test_Database_deleteCard () {
        let card: Card = Card()
        XCTAssertNoThrow(database.deleteCard(from: .favoriteCards, at: card))
    }
    
    func test_Database_deleteAllCards () {
        XCTAssertNoThrow(database.deleteAllCards(from: .favoriteCards))
    }
    
    func test_Database_laodFavoriteCards () {
        XCTAssertNoThrow(database.loadFavoriteCards(from: .favoriteCards))
    }
}

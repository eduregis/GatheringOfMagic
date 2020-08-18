//
//  CardViewControllerTests.swift
//  GatheringOfMagicTests
//
//  Created by Eduardo Oliveira on 17/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import XCTest

@testable import GatheringOfMagic

class CardViewControllerTests: XCTestCase {
    
    func test_CardViewController_cardManaCost () {
        // given
        let sut = CardViewController()
        
        // then
        XCTAssertNoThrow(sut.cardManaCost())
    }
    
    func test_CardViewController_setupNavigationItemBar () {
        // given
        let sut = CardViewController()
        
        // then
        XCTAssertNoThrow(sut.setupNavigationItemBar())
    }
    
    func test_CardViewController_isFavorited() {
        // given
        let sut = CardViewController()
        sut.isFavorite = false
        // then
        XCTAssertNoThrow(sut.isFavorited())
    }
}

class SetViewControllerTests: XCTestCase {
    func test_TabBarViewController_viewDidLoad() {
        //given
        let sut = SetViewController()
        
        //then
        XCTAssertNoThrow(sut.viewDidLoad())
    }
    
    func test_TabBarViewController_makeRequest() {
        //given
        let sut = SetViewController()
        
        //then
        XCTAssertNoThrow(sut.makeRequest(name: "10E"))
    }
}

class GatheringViewControllerTests: XCTestCase {
    func test_GatheringViewController_setupNavigationItemBar () {
        // given
        let sut = GatheringViewController()
        
        // then
        XCTAssertNoThrow(sut.setupNavigationbarItems())
    }
    
    func test_GatheringViewController_makeRequest_withString() {
        //given
        let sut = GatheringViewController()
        
        //then
        XCTAssertNoThrow(sut.makeRequest(name: "Marauding"))
    }
    
    func test_GatheringViewController_makeRequest() {
        //given
        let sut = GatheringViewController()
        
        //then
        XCTAssertNoThrow(sut.makeRequest())
    }
}

class TabBarViewControllerTests: XCTestCase {
    func test_TabBarViewController_viewDidLoad() {
        //given
        let sut = TabBarViewController()
        
        //then
        XCTAssertNoThrow(sut.viewDidLoad())
    }
}

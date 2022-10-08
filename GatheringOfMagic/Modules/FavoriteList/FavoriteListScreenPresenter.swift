//
//  FavoriteListScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import Foundation

protocol FavoriteListScreenPresenterDelegate: BasePresenterDelegate {
}

class FavoriteListScreenPresenter {
    
    weak var delegate: FavoriteListScreenPresenterDelegate?
    let router: FavoriteListScreenRouter
    
    init(delegate: FavoriteListScreenPresenterDelegate, router: FavoriteListScreenRouter) {
        
        self.delegate = delegate
        self.router = router
    }
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func navigateToCardList() {
    }
}

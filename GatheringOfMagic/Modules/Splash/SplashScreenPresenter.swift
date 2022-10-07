//
//  SplashScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation

protocol SplashScreenPresenterDelegate: BasePresenterDelegate {
}

class SplashScreenPresenter {
    
    weak var delegate: SplashScreenPresenterDelegate?
    let router: SplashScreenRouter
    
    init(delegate: SplashScreenPresenterDelegate, router: SplashScreenRouter) {
        
        self.delegate = delegate
        self.router = router
    }
    func didLoad() {
        checkInternet()
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func navigateToCardList() {
        router.navigateToCardList()
    }
    
    @objc func checkInternet() {
        let connection = ConnectionObject.sharedInstance
        if connection.isConnectedToInternet() {
            navigateToCardList()
        }
    }
}

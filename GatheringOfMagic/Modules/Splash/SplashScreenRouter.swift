//
//  SplashScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class SplashScreenRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        
        let viewController = SplashScreenViewController()
        let router = SplashScreenRouter(viewController: viewController)
        let presenter = SplashScreenPresenter(delegate: viewController, router: router)
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = true
        viewController.presenter = presenter
        
        return navigation
    }
    
    func navigateToCardList() {
        self.push(CardListScreenRouter.makeModule(), animated: true)
    }
}

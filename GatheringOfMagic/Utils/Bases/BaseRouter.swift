//
//  BaseRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class BaseRouter {
    
    weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        self.viewController?.present(viewController, animated: animated, completion: nil)
    }
    
    func presentOnNavigation(_ viewController: UIViewController, animated: Bool) {
        self.viewController?.navigationController?.present(viewController, animated: animated, completion: nil)
    }
    
    func presentOverContext(_ viewController: UIViewController, animated: Bool, modalPresentation: Bool) {
        
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.viewController?.present(viewController, animated: animated, completion: nil)
    }
    
    func pop(animated: Bool) {
        self.viewController?.navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        self.viewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        self.viewController?.dismiss(animated: animated, completion: nil)
    }
    
    class func setupTabBarAppearenceFor(_ viewController: UIViewController,
                                        title: String,
                                        selectedImage: UIImage!,
                                        unselectedImage: UIImage!) {
        viewController.tabBarItem.image = unselectedImage.withRenderingMode(.automatic)
        viewController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.automatic)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.accessibilityLabel = title
    }
}


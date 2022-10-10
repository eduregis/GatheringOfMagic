//
//  BaseViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

protocol BaseViewControllerMethods {
    func showLoader()
    func hideLoader()
    func showMessage(_ message: String)
}

class BaseViewController: UIViewController, BaseViewControllerMethods {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var greyView = UIView()
    
    @objc func showLoader() {
        guard let window = AppDelegate.windowView else { return }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = window.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        let transfrom = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transfrom
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        greyView.frame = CGRect(x: 0, y: 0, width: window.bounds.width, height: window.bounds.height)
        greyView.backgroundColor = UIColor.black
        greyView.alpha = 0.6
        self.view.addSubview(greyView)
    }
    
    @objc func hideLoader() {
        self.activityIndicator.stopAnimating()
        self.greyView.removeFromSuperview()
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: AlertTexts.alert.localized(),
                                      message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AlertTexts.ok.localized(), style: .default, handler: {_ in
            self.hideLoader()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

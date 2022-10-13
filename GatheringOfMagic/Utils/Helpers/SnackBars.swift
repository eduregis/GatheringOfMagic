//
//  SnackBars.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 10/10/22.
//

import UIKit
import SwiftMessages

class SnackBarHelper: NSObject {

    static let shared = SnackBarHelper()
    private override init() {}
    
    enum ToastMessagesTheme {
        case success
        case error
    }
    
    func showSuccessMessage(message: String, duration: TimeInterval = 1.5) {
        showMessage(title: SnackBarTitleMessages.success.localized(), message: message, duration: duration, type: .success)
    }
    
    func showErrorMessage(message: String, duration: TimeInterval = 1.5) {
        showMessage(title: SnackBarTitleMessages.failure.localized(), message: message, duration: duration, type: .error)
    }
    
    func showMessage(title: String, message: String, duration: TimeInterval, type: ToastMessagesTheme) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .seconds(seconds: duration)
        config.preferredStatusBarStyle = .lightContent
        
        switch type {
        case .success:
            view.configureTheme(.success)
            
        case .error:
            view.configureTheme(.error)
        }
        
        SwiftMessages.show(config: config, view: view)
    }
    
}

//
//  BasePresenterDelegate.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

protocol BasePresenterDelegate where Self: UIViewController {
    func showLoader()
    func hideLoader()
    func showMessage(_ message: String)
}

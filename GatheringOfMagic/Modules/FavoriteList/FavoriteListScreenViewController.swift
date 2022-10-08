//
//  FavoriteListScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class FavoriteListScreenViewController: BaseViewController {

    // MARK: - Outlets
    
    
    // MARK: - Properties
    var presenter: FavoriteListScreenPresenter!
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()
        self.view.backgroundColor = .systemRed
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods

    // MARK: - Actions
    
}

// MARK: - SplashScreenPresenterDelegate
extension FavoriteListScreenViewController: FavoriteListScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

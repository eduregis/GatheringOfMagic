//
//  SplashScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class SplashScreenViewController: BaseViewController {

    // MARK: - Outlets
    
    
    // MARK: - Properties
    var presenter: SplashScreenPresenter!
    
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
        self.blurBackground()
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
    func navigateToCardList() {
        self.presenter.navigateToCardList()
    }
}

// MARK: - SplashScreenPresenterDelegate
extension SplashScreenViewController: SplashScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

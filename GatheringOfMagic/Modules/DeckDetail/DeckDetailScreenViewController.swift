//
//  DeckDetailScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit
import CoreData

class DeckDetailScreenViewController: BaseViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    var presenter: DeckDetailScreenPresenter!
    
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
        self.actualizeUI()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.completionHandler!()
    }
    
    // MARK: - Methods
    func actualizeUI() {
//        deckName.text = presenter.currentDeck?.name
    }
}

// MARK: - CardDetailScreenPresenterDelegate
extension DeckDetailScreenViewController: DeckDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

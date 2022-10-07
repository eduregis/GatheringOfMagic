//
//  CardDetailScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class CardDetailScreenViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var cardImage: UIImageView!
    
    // MARK: - Properties
    var isBlocked = false
    var presenter: CardDetailScreenPresenter!
    
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
        presenter.loadCard(completion: {
            self.actualizeUI()
        })
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
    func actualizeUI() {
        cardImage.sd_setImage(with: URL(string: presenter.currentCard?.imageUrl?.protocolAPS() ?? ""), placeholderImage: UIImage(named: "backCard.png"))
        cardImage.layer.cornerRadius = 20
    }
    
    func blurBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(blurEffectView)
        self.view.sendSubviewToBack(blurEffectView)
    }

    // MARK: - Actions
    func navigateToCardList() {
        self.presenter.router.backToList()
    }
}

// MARK: - CardDetailScreenPresenterDelegate
extension CardDetailScreenViewController: CardDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

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
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var cardsInDeckLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var curveLabel: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var cardsCVHeightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionOfManaCostIcons: Array<UIImageView>?
    @IBOutlet weak var manaCostXConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var presenter: DeckDetailScreenPresenter!
    var isAnimating: Bool = false
    
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
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        self.changeCollectionHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        navigationController?.navigationBar.tintColor = UIColor.white
        deckName.text = presenter.currentDeck?.name
        cardsInDeckLabel.text = "\(presenter.currentDeck?.format ?? "") (\(presenter.totalCardsInDeck()))"
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
        self.blurBackground()
        
        setupNavigationButton()
        
        guard let currentDeck = presenter.currentDeck else { return }
        let cards = DataManager.shared.getCards(deck: currentDeck)
        
        setManaIcons(cards: cards)
        setAverageCosts()
        setCurveCost()
        
        setupLongGestureRecognizerOnCollection()
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        headerContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        deckName.text = presenter.currentDeck?.name
        cardsInDeckLabel.text = "\(presenter.currentDeck?.format ?? "") (\(presenter.totalCardsInDeck()))"
        manaLabel.text = DeckDetailScreenTexts.mana.localized()
        averageCostLabel.text = DeckDetailScreenTexts.averageCost.localized()
        curveLabel.text = DeckDetailScreenTexts.curve.localized()
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.cardsCollectionView.delegate = self
        self.cardsCollectionView.dataSource = self
        CardListCollectionViewCell.registerNib(for: cardsCollectionView)
        cardsCollectionView?.register(DeckDetailCollectionViewHeader.self, forSupplementaryViewOfKind:
                                        UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        self.cardsCollectionView.backgroundColor = UIColor.clear
    }
    
    func changeCollectionHeight() {
        self.cardsCVHeightConstraint.constant = self.cardsCollectionView.contentSize.height
    }
    
    func setManaIcons(cards: [CD_CardDetail]) {
        
        clearManaCosts()
        
        var manaColors: [String] = []
        
        if cards.contains(where: {$0.manaCost!.contains("B")}) { manaColors.append("mana_B") }
        if cards.contains(where: {$0.manaCost!.contains("G")}) { manaColors.append("mana_G") }
        if cards.contains(where: {$0.manaCost!.contains("R")}) { manaColors.append("mana_R") }
        if cards.contains(where: {$0.manaCost!.contains("U")}) { manaColors.append("mana_U") }
        if cards.contains(where: {$0.manaCost!.contains("W")}) { manaColors.append("mana_W") }
        
        guard let manaCostIcons = collectionOfManaCostIcons else { return }
        
        for (manaCostIcon, manaColor) in zip(manaCostIcons, manaColors) {
            manaCostIcon.image = UIImage(named: manaColor)
        }
        
        manaCostXConstraint.constant = CGFloat((manaColors.count - 1) * -16)
    }
    
    func clearManaCosts() {
        guard let manaCostIcons = collectionOfManaCostIcons else { return }
        for manaCostIcon in manaCostIcons {
            manaCostIcon.image = nil
        }
    }
    
    func setAverageCosts() {
        cost.text = "\(presenter.averageCostInDeck())"
    }
    
    func setupNavigationButton() {
        let btn: UIButton = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.contentMode = .right

        btn.setTitle(DeckDetailScreenTexts.edit.localized(), for: .normal)
        btn.addTarget(self, action: #selector(navigateToEditDeck), for: .touchDown)
        let backBarButton: UIBarButtonItem = UIBarButtonItem(customView: btn)

        self.navigationItem.setRightBarButtonItems([backBarButton], animated: false)
    }
    
    func setCurveCost() {
        
        let colorCurve = presenter.curveColors()
        
        let maxValueCurve: Int = colorCurve.max() ?? 0

        for index in 1...colorCurve.count {
            
            let filledView = UIView()
            filledView.translatesAutoresizingMaskIntoConstraints = false
            filledView.backgroundColor = .systemYellow
            filledView.layer.cornerRadius = 5
            
            let curveView = UIView()
            curveView.translatesAutoresizingMaskIntoConstraints = false
            curveView.backgroundColor = .clear
            curveView.layer.borderWidth = 3
            curveView.layer.borderColor = UIColor.white.cgColor
            curveView.layer.cornerRadius = 5
            
            let title = UILabel()
            title.font = UIFont(name: "Helvetica", size: 13)
            title.textColor = .gray
            title.text = (index == 6) ? "6+" : "\(index)"
            title.translatesAutoresizingMaskIntoConstraints = false
            
            self.headerContainer.addSubview(filledView)

            filledView.centerXAnchor.constraint(equalTo: curveLabel.centerXAnchor, constant: CGFloat(index * 50) - 175).isActive = true
            filledView.bottomAnchor.constraint(equalTo: curveLabel.topAnchor, constant: -10).isActive = true
            filledView.heightAnchor.constraint(equalToConstant: CGFloat(colorCurve[index - 1] * 80 / maxValueCurve)).isActive = true
            filledView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            self.headerContainer.addSubview(curveView)

            curveView.centerXAnchor.constraint(equalTo: curveLabel.centerXAnchor, constant: CGFloat(index * 50) - 175).isActive = true
            curveView.bottomAnchor.constraint(equalTo: curveLabel.topAnchor, constant: -10).isActive = true
            curveView.heightAnchor.constraint(equalToConstant: 105).isActive = true
            curveView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            self.headerContainer.addSubview(title)

            title.centerXAnchor.constraint(equalTo: curveLabel.centerXAnchor, constant: CGFloat(index * 50) - 175).isActive = true
            title.bottomAnchor.constraint(equalTo: curveView.topAnchor, constant: -10).isActive = true
        }
        
        
    }
    
    @objc func navigateToEditDeck() {
        presenter.navigateToEditDeck()
    }
}

// MARK: - CardDetailScreenPresenterDelegate
extension DeckDetailScreenViewController: DeckDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension DeckDetailScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CardTypes.total.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionSection = CardTypes(rawValue: section), let cardData = presenter.sortedCards[collectionSection] {
            return cardData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let collectionSection = CardTypes(rawValue: section) {
            if (presenter.sortedCards[collectionSection]!.count > 0) {
                return CGSize(width: view.frame.width, height: 30)
            }
        }
        
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "headerId",
                for: indexPath) as! DeckDetailCollectionViewHeader
        if let collectionSection = CardTypes(rawValue: indexPath.section) {
            header.typeLabel.text = presenter.titleForHeader(type: collectionSection)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        if let collectionSection = CardTypes(rawValue: indexPath.section), let card = presenter.sortedCards[collectionSection]?[indexPath.row] {
            cell.fill(
                name: card.name,
                imageURL: card.imageUrl,
                quantity: Int(card.quantity))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize/4, height: 187)
    }
    
    func reloadData() {
        guard let currentDeck = presenter.currentDeck else { return }
        let cards = DataManager.shared.getCards(deck: currentDeck)
        setManaIcons(cards: cards)
        setAverageCosts()
        cardsInDeckLabel.text = "\(presenter.currentDeck?.format ?? "") (\(presenter.totalCardsInDeck()))"
        cardsCollectionView.reloadData()
    }
}

// MARK: - Long Press Gesture
extension DeckDetailScreenViewController: UIGestureRecognizerDelegate {
    
    private func setupLongGestureRecognizerOnCollection() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.cardsCollectionView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        guard gestureReconizer.state != .began else { return }
        let point = gestureReconizer.location(in: self.cardsCollectionView)
        guard let indexPath = self.cardsCollectionView.indexPathForItem(at: point) else { return }
        if (!isAnimating) {
            
            isAnimating = true
            
            UIView.animate(withDuration: 0.3, animations: {
                if let cell = self.cardsCollectionView.cellForItem(at: indexPath) as? CardListCollectionViewCell {
                    cell.transform = CGAffineTransform(scaleX: 19/20, y: 19/20)
                }
            }) { (completed) in
                
                self.isAnimating = false
                
                if let collectionSection = CardTypes(rawValue: indexPath.section), let card = self.presenter.sortedCards[collectionSection]?[indexPath.row] {
                    let customAlert = EditCardQuantityAlert(card: card)
                    customAlert.delegate = self
                    customAlert.show()
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                   if let cell = self.cardsCollectionView.cellForItem(at: indexPath) as? CardListCollectionViewCell {
                       cell.transform = .identity
                   }
               })
            }
        }
    }
}

extension DeckDetailScreenViewController: EditCardQuantityAlertDelegate {
    func confirmButtonPressed(_ alert: EditCardQuantityAlert) {
        presenter.reloadDeck()
        self.reloadData()
    }
    
    func cancelButtonPressed(_ alert: EditCardQuantityAlert) {
    }
}

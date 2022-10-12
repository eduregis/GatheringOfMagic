//
//  EditCardQuantityAlert.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 12/10/22.
//

import UIKit

protocol EditCardQuantityAlertDelegate: AnyObject {
    func confirmButtonPressed(_ alert: EditCardQuantityAlert)
    func cancelButtonPressed(_ alert: EditCardQuantityAlert)
}
class EditCardQuantityAlert: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardQuantity: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    weak var delegate: EditCardQuantityAlertDelegate?
    var card: CD_CardDetail?
    var quantity: Int16 = 0

    init(card: CD_CardDetail) {
        super.init(nibName: "EditCardQuantityAlert", bundle: Bundle(for: EditCardQuantityAlert.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.card = card
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlert()
    }
    
    func show() {
        if #available(iOS 13, *) {
            UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
        }
    }
    
    func setupAlert() {
        guard let card = card else { return }
        cardName.text = card.name
        quantity = card.quantity
        cancelButton.setTitle("Cancel", for: .normal)
        confirmButton.setTitle("Confirm", for: .normal)
        actualizeUI()
    }
    
    func actualizeUI() {
        cardQuantity.text = "\(quantity)"
        guard let card = card else { return }
        if let type = card.type, !type.contains("Basic Land") {
            plusButton.isEnabled = !(quantity == 4)
        }
        minusButton.isEnabled = !(quantity == 0)
    }
    
    
    @IBAction func minusAction(_ sender: Any) {
        quantity -= 1
        actualizeUI()
        
    }
    
    @IBAction func plusAction(_ sender: Any) {
        quantity += 1
        actualizeUI()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.cancelButtonPressed(self)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        card?.quantity = quantity
        DataManager.shared.save()
        delegate?.confirmButtonPressed(self)
    }
    
}



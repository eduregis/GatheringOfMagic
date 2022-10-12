//
//  EditDeckScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 12/10/22.
//

import UIKit

class EditDeckScreenViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var editTableView: UITableView!
    
    // MARK: - Properties
    var presenter: EditDeckScreenPresenter!
    
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
        editTableView.backgroundColor = UIColor.clear
        editTableView.delegate = self
        editTableView.dataSource = self
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
extension EditDeckScreenViewController: EditDeckScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension EditDeckScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.tableViewInfos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : DeckFormats.allValues.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.tableViewInfos[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let cell = EditDeckEditableTableViewCell.dequeueCell(from: tableView)
            let textRow = TextInputFormItem(text: presenter.name ?? "", placeholder: presenter.name ?? "", didChange: {_ in
                self.presenter.name = cell.editableTextField.text
            })
            cell.configure(for: textRow)
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            let cell = UITableViewCell.dequeueCell(from: tableView)
            let format = presenter.formatForDeck(format: DeckFormats(rawValue: indexPath.row) ?? DeckFormats.standard)
            cell.textLabel?.text = format
            if (presenter.format == format) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
           // chamar teclado
        } else {
            presenter.format = presenter.formatForDeck(format: DeckFormats(rawValue: indexPath.row) ?? DeckFormats.standard)
            editTableView.reloadData()
        }
    }
    
    
}

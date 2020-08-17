//
//  SetViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 16/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class SetViewController: UITableViewController {
    
    var setCode: String?
    
    var set: MTGSetDetails? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let setCode = self.setCode {
            makeRequest(name: setCode)
        }
        tableView.tableFooterView = UIView()
    }
    
    func makeRequest (name: String) {
        let cardRequest = MTGRequest(typeOfRequest: .sets, name: name)
        cardRequest.getSets { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let set):
                self?.set = set
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setInfo", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name: \(set?.name ?? "-")"
        case 1:
            cell.textLabel?.text = "Type: \(set?.type ?? "-")"
        case 2:
            cell.textLabel?.text = "Code: \(set?.code ?? "-")"
        case 3:
            cell.textLabel?.text = "Block: \(set?.block ?? "-")"
        default:
            cell.textLabel?.text = "Release date: \(set?.releaseDate ?? "-")"
        }
        return cell
    }
}

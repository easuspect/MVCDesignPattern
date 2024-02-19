//
//  ViewController.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: ViewControllerDataSource!
    private var model = ViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        model.fetchUsers()

    }
    func didNextPageButtonPressed() {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailPageVC") as? DetailPageVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ViewController {
    
    func setupUI() {
        dataSource = .init(tableView: tableView, vc: self)
        model.delegate = self
    }
}

extension ViewController: ViewControllerModelDelegate {
    func didUserFetch(_ users: [User]) {
        dataSource.updateData(with: users)
    }
}

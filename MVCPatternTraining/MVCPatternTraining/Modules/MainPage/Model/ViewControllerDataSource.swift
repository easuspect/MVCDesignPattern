//
//  ViewControllerDataSource.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import Foundation
import UIKit

class ViewControllerDataSource: NSObject {
    
    let userCell = "UserCell"
    var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private weak var tableView: UITableView!
    private weak var viewController : ViewController!
    
    init(tableView: UITableView, vc: ViewController) {
        super.init()
        self.tableView = tableView
        self.viewController = vc
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: userCell)
        
        
    }
}

//MARK: -UPDATE DATA
extension ViewControllerDataSource {
    func updateData(with item: [User]) {
        users = item
    }
}

//MARK: -DELEGATE AND DATASOURCE
extension ViewControllerDataSource: UITableViewDelegate {
    
}

extension ViewControllerDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell) as! UserCell
        let user = users[indexPath.row]
            cell.nameLabel.text = users[indexPath.row].name
            cell.userNameLabel.text = users[indexPath.row].username
            cell.emailLabel.text = users[indexPath.row].email
        
            cell.contentView.backgroundColor = .systemBlue
            cell.containerView.backgroundColor = .white
            cell.containerView.layer.cornerRadius = 10
            cell.detailedNextButtonPressed.backgroundColor = .orange
            cell.detailedNextButtonPressed.layer.cornerRadius = 10
            cell.detailedNextButtonPressed.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 5).cgColor
            cell.detailedNextButtonPressed.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
            cell.detailedNextButtonPressed.layer.shadowOpacity = 10.0
            cell.detailedNextButtonPressed.layer.shadowRadius = 10.0
            cell.detailedNextButtonPressed.layer.masksToBounds = false
            
            cell.delegate = self
            cell.indexPath = indexPath
 //MARK: - CONSTRAINT EXPAND BUTTON
        if user.isExpanded ?? false {
                
                cell.showRemoveButton.setImage(UIImage(named: "upArrow"), for: .normal)
                cell.containerViewHeightConstraint.isActive = false
                cell.emailLabel.isHidden = false
                cell.userNameLabel.isHidden = false
            } else {
                cell.showRemoveButton.setImage(UIImage(named: "downArrow"), for: .normal)
                cell.containerViewHeightConstraint.isActive = true
                cell.emailLabel.isHidden = true
                cell.userNameLabel.isHidden = true
            }
//MARK: - ON CLICK EXPAND BUTTON
           cell.onClickExpandButton = { [weak self] in
            
            if (self?.users[indexPath.row].isExpanded ?? false) {
                self?.users[indexPath.row].isExpanded = false
            } else {
                self?.users[indexPath.row].isExpanded = true
            }
            self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
            return cell
    }
}

//MARK: -DETAILED PAGE BUTTON
extension ViewControllerDataSource: UserCellDelegate {
    func detailedPressButton(_ indexpath: IndexPath) {
        viewController.didNextPageButtonPressed()
    }
    
    
}

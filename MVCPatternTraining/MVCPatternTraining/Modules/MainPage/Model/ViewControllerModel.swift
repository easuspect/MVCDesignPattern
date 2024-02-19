//
//  ViewControllerModel.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import Foundation

protocol ViewControllerModelDelegate: AnyObject {
    
    func didUserFetch(_ users: [User])
}

class ViewControllerModel: NSObject {

    weak var delegate: ViewControllerModelDelegate!
    
    func fetchUsers() {
        ApiRequestHandler.request { [weak self] result in
            switch result {
            case .success(let users):
                self?.delegate?.didUserFetch(users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

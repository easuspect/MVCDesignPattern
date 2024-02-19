//
//  UserCell.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import UIKit


protocol UserCellDelegate: AnyObject {
    func detailedPressButton(_ indexpath: IndexPath)
}

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var showRemoveButton: UIButton!
    @IBOutlet weak var detailedNextButtonPressed: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var onClickExpandButton: (() -> ())?
    weak var delegate: UserCellDelegate?
    var indexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func expandButtonPressed(_ sender: Any) {
        onClickExpandButton?()
    }
    
    @IBAction func detailedButtonPressed(_ sender: Any) {
        delegate?.detailedPressButton(indexPath)
    }
}

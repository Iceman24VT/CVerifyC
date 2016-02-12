//
//  UserCell.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var institutionLbl: UILabel!
    @IBOutlet weak var percentCompleteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(user: UserData) {
        if let firstName = user.firstName, lastName = user.lastName {
            userNameLbl.text = "\(firstName.capitalizedString) \(lastName.capitalizedString)"
        }
        if let institution = user.institution {
            institutionLbl.text = institution.capitalizedString
        }
        if let percentComplete = user.getPercentCompleteInt() {
            percentCompleteLbl.text = "\(percentComplete)% Complete"
        }
    }
}

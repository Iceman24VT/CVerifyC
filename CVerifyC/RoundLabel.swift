//
//  RoundLabel.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}

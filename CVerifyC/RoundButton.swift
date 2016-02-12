//
//  RoundButton.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        //backgroundColor = UIColor(red: 46.0/255.0, green: 135.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        //setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
}

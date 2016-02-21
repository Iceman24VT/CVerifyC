//
//  Question.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var image: UIImage!
    var mask: UIImage!
    var prompt: String!
    var correctResponse: String!
    var incorrectResponse: String!
    
    init(){
        
    }
    
    init(image: UIImage, mask: UIImage, prompt: String, correctResponse: String, incorrectResponse: String){
        self.image = image
        self.mask = mask
        self.prompt = prompt
        self.correctResponse = correctResponse
        self.incorrectResponse = incorrectResponse
    }
}
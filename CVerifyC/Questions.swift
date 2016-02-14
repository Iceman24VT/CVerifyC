//
//  Questions.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/13/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Questions {
    private var _app: AppDelegate!
    private var _context: NSManagedObjectContext!
    
    private var _questions = [QuestionData]()
    
    init() {
        
    }
    
    func getImage(questionNumber: Int) -> UIImage {
        //grab image
        let questionImg = UIImage(named: "Q\(questionNumber + 1)")
        
        return questionImg!
    }
}
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
    private var _questions = [Question]()
    private var _currentQuestion: Int!
    private var _numberQuestions: Int!
    
    init() {
        _loadQuestions()
        _currentQuestion = 1
        _numberQuestions = 5
    }
    
    func getImage(questionNumber: Int) -> UIImage {
        //grab image
        let questionImg = UIImage(named: "Q\(questionNumber + 1)")
        
        return questionImg!
    }
    
    func getCurrentQuestionImage() -> UIImage {
        let questionImg = UIImage(named: "Q\(_currentQuestion)")
        return questionImg!
    }
    
    func getCurrentQuestionPrompt() -> String {
        return ""
    }
    
    func getCurrentQuestionMask() -> UIImage {
        let questionImg = UIImage(named: "Q\(_currentQuestion)A")
        return questionImg!
    }
    
    func goToNextQuestion () {
        if _currentQuestion < _numberQuestions {
            _currentQuestion = _currentQuestion + 1
        }
    }
    
    private func _loadQuestions(){
//        var index: Int = 0
//        while true {
//            if let image = UIImage(named: "Q\(index)I") {
//            
//            } else {
//                break
//            }
//            
//            index++
//        }
    }
}
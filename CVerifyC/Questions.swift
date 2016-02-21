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
    }
    
    func getImage(questionNumber: Int) -> UIImage {
        return _questions[questionNumber - 1].image
    }
    
    func getCurrentQuestionImage() -> UIImage {
        return _questions[_currentQuestion - 1].image
    }
    
    func getCurrentQuestionPrompt() -> String {
        return _questions[_currentQuestion - 1].prompt
    }
    
    func getCurrentQuestionMask() -> UIImage {
        return _questions[_currentQuestion - 1].mask
    }
    
    func currentSubmissionCorrect(submissionPoint: CGPoint) -> Bool {
        return false
    }
    
    func goToNextQuestion () -> Bool{
        if _currentQuestion < _numberQuestions {
            _currentQuestion = _currentQuestion + 1
            return true
        } else {
            _currentQuestion = 1
            return false
        }
    }
    
    private func _loadQuestions(){
        var index: Int = 0
        var image: UIImage!
        var mask: UIImage!
        var prompt: String!
        var correctResponse: String!
        var incorrectResponse: String!
        
        _numberQuestions = 0
        
        while true {
            if let loadImage = UIImage(named: "Q\(index + 1)I") {
                image = loadImage
            } else {
                break
            }
            
            if let loadMask = UIImage(named: "Q\(index + 1)M") {
                mask = loadMask
            } else {
                break
            }
            
            if let asset = NSDataAsset(name: "Q\(index + 1)T", bundle: NSBundle.mainBundle()){
                let json = try? NSJSONSerialization.JSONObjectWithData(asset.data, options: NSJSONReadingOptions.AllowFragments)
                prompt = json!["PROMPT"] as! String
                correctResponse = json!["CORRECT_RESPONSE"] as! String
                incorrectResponse = json!["CORRECT_RESPONSE"] as! String
            } else {
                break
            }
            
            _questions.append(Question(image: image, mask: mask, prompt: prompt, correctResponse: correctResponse, incorrectResponse: incorrectResponse))
            
            _numberQuestions = _numberQuestions + 1
            index++
        }
        
        print("\(_numberQuestions) questions loaded")
    }
}
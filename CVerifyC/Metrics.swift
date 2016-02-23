//
//  Metrics.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Metrics {
    private var _app: AppDelegate!
    private var _context: NSManagedObjectContext!
    
    private var _metrics = [UserMetrics]()
    private var _currentUserId: String?
    
    init(){
        _app = UIApplication.sharedApplication().delegate as! AppDelegate
        _context = _app.managedObjectContext
        
        self.loadUserMetrics()
    }
    
    var userMetrics: [UserMetrics]? {
        return _metrics
    }
    
    var count: Int! {
        return _metrics.count
    }
    
    func setCurrentUser(newCurrentUser: String) {
        _currentUserId = newCurrentUser
    }
    
    func addUserMetric(userId: String, question: Int32, correct: QuestionStatus, iteration: Int) {
        var newUserMetric: UserMetrics!
        newUserMetric = addMetric(userId, question: question, correct:  correct, iteration: iteration)
    }
    
    func addMetric(userId: String, question: Int32, correct: QuestionStatus, iteration: Int) -> UserMetrics {
        let entity = NSEntityDescription.entityForName("UserMetrics", inManagedObjectContext: _context)!
        let userMetric = UserMetrics(entity: entity, insertIntoManagedObjectContext: _context)
        
        let correctHash = Int32(correct.hashValue)
        
        userMetric.userId = userId
        userMetric.questionNumber = NSNumber(int: question)
        userMetric.questionCorrect = NSNumber(int: correctHash)
        userMetric.iteration = NSNumber(int: Int32(iteration))
        
        _context.insertObject(userMetric)
        
        setUserMetrics()
        loadUserMetrics()
        
        return userMetric
    }
    
     func loadUserMetrics(){
        let fetchRequest = NSFetchRequest(entityName: "UserMetrics") //datamodel name
        
        do {
            let results = try _context.executeFetchRequest(fetchRequest)
            self._metrics = results as! [UserMetrics]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    private func setUserMetrics(){
        do {
            try _context.save()
        } catch {
            print("Could not save user")
        }
    }
    
    func printUserMetrics(userId: String) {
        print("All metrics for: \(userId)")
        for metric in _metrics {
            if userId == metric.userId {
                print(" Question:\(metric.questionNumber!), Status:\(stringForQuestionStatusHash(Int(metric.questionCorrect!))), iteration:\(metric.iteration!)")
            }
        }
    }
    
    func getPercentFinishedForUserIdSession(userId: String, iteration: NSNumber) -> Double {
        var userCount = 0
        
        for metric in _metrics {
            if userId == metric.userId && iteration == metric.iteration {
                if metric.questionCorrect == QuestionStatus.correct.hashValue {
                    userCount++
                }
            }
        }
        
        return Double(userCount)/Double(questions.getTotalNumberOfQuestions())
    }
    
    func getPercentCorrectForUserId(userId: String) -> Double {
        let correctQues = getNumberCorrect(userId)
        let incorrectQues = getNumberIncorrect(userId)
        
        return Double(correctQues) / Double(incorrectQues + correctQues)
    }
    
    func getPercentCorrectForUserIdSession(userId: String, iteration: NSNumber) -> Double {
        let correctQues = getNumberCorrectSession(userId, iteration: iteration)
        let incorrectQues = getNumberIncorrectSession(userId, iteration: iteration)
    
        return Double(correctQues) / Double(incorrectQues + correctQues)
    }
    
    func getNumberCorrectSession(userId: String, iteration: NSNumber) -> Int {
        var userCount = 0
        
        for metric in _metrics {
            if userId == metric.userId && iteration == metric.iteration {
                if metric.questionCorrect == Question_Correct {
                    userCount++
                }
            }
        }
        
        return userCount
    }

    func getNumberIncorrectSession(userId: String, iteration: NSNumber) -> Int {
        var userCount = 0
        
        for metric in _metrics {
            if userId == metric.userId && iteration == metric.iteration {
                if metric.questionCorrect == Question_Incorrect {
                    userCount++
                }
            }
        }
        
        return userCount
    }
    
    func getNumberCorrect(userId: String) -> Int {
        var userCount = 0
        
        for metric in _metrics {
            if userId == metric.userId {
                if metric.questionCorrect == Question_Correct {
                    userCount++
                }
            }
        }
        
        return userCount
    }
    
    func getNumberIncorrect(userId: String) -> Int {
        var userCount = 0
        
        for metric in _metrics {
            if userId == metric.userId {
                if metric.questionCorrect == Question_Incorrect {
                    userCount++
                }
            }
        }
        
        return userCount
    }
    
    func getFirstWrongQuestion(userId: String, iteration: NSNumber) -> Int {
        let numQuestions = questions.getTotalNumberOfQuestions()
        var firstWrong = numQuestions + 10000
        let questionArray = _getCurrentQuestionArray(userId, iteration: iteration)
        
        for var x=0; x < numQuestions; x++ {
            if questionArray[x] == Question_Incorrect {
                firstWrong = x + 1
                break
            }
        }
        
        return firstWrong
    }
    
    private func _getCurrentQuestionArray(userId: String, iteration: NSNumber) -> [Int] {
        let numQuestions = questions.getTotalNumberOfQuestions()
        var questionArray = [Int](count: numQuestions, repeatedValue: Question_Incomplete)
       
        for metric in _metrics {
            if userId == metric.userId && iteration == metric.iteration {
                
                if questionArray[Int(metric.questionNumber!)-1] == Question_Incomplete || questionArray[Int(metric.questionNumber!)-1] == Question_Incorrect {
                    
                    questionArray[Int(metric.questionNumber!)-1] = Int(metric.questionCorrect!)
                }
                
                //print("User \(userId), iteration \(iteration), question \(metric.questionNumber!), status \(stringForQuestionStatusHash(questionArray[Int(metric.questionNumber!)-1]))")
            }
        }
        
        return questionArray
    }
    
    func getLastAnsweredQuestion(userId: String, iteration: NSNumber) -> Int {
        var lastAnswered = 0
        
        for metric in _metrics {
            if userId == metric.userId && iteration == metric.iteration {
                let metricQuestionNumber = Int(metric.questionNumber!)
                
                if  metricQuestionNumber > lastAnswered {
                    lastAnswered = metricQuestionNumber
                }
            }
        }
        
        return lastAnswered
    }
 
    func userAnsweredAnyQuestions(userId: String) -> Bool{
        for metric in _metrics {
            if userId == metric.userId {
                return true
            }
        }
        
        return false
    }
    
    func printAllMetrics() {
        print("All metrics:")
        for metric in _metrics {
            print("User Id: \(metric.userId), Question:\(metric.questionNumber), Status:\(stringForQuestionStatusHash(Int(metric.questionCorrect!))), iteration:\(metric.iteration)")
        }
    }
}
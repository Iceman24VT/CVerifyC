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
    
    func addUserMetric(userId: String, question: Int32, correct: QuestionStatus, iteration: Int32) {
        var newUserMetric: UserMetrics!
        newUserMetric = addMetric(userId, question: question, correct:  correct, iteration: iteration)
    }
    
    private func addMetric(userId: String, question: Int32, correct: QuestionStatus, iteration: Int32) -> UserMetrics {
        let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: _context)!
        let userMetric = UserMetrics(entity: entity, insertIntoManagedObjectContext: _context)
        
        let correctHash = Int32(correct.hashValue)
        
        userMetric.userId = userId
        userMetric.questionNumber = NSNumber(int: question)
        userMetric.questionCorrect = NSNumber(int: correctHash)
        userMetric.iteration = NSNumber(int: iteration)
        
        _context.insertObject(userMetric)
        
        setUserMetrics()
        
        return userMetric
    }
    
    private func loadUserMetrics(){
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
    
    private func printUserMetrics(userId: String) {
        for metric in _metrics {
            if userId == metric.userId {
                print("User Id: \(metric.userId), Question:\(metric.questionNumber), Correct:\(metric.questionCorrect), iteration:\(metric.iteration)")
            }
        }
    }
    
}
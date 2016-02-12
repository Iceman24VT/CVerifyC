//
//  CurrentUserData.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CurrentUserData {
    private var _currentUserData: UserData?
    
    var users = [UserData]()
    
    var currentUser: UserData? {
        return _currentUserData
    }
    
    var firstName: String {
        if let firstName = _currentUserData?.firstName {
            return firstName
        } else {
            return ""
        }
    }
    
    var lastName: String {
        if let lastName = _currentUserData?.lastName {
            return lastName
        } else {
            return ""
        }
    }
    
    var institution: String {
        if let institution = _currentUserData?.institution {
            return institution
        } else {
            return ""
        }
    }
 
    var percentComplete: Int {
        if let percentComplete = _currentUserData?.getPercentCompleteInt() {
            return percentComplete
        } else {
            return -1
        }
    }
    
    var userId: NSNumber {
        if let userId = _currentUserData?.userId {
            return userId
        } else {
            return -1
        }
    }
    
    var trainingLevel: String {
        if let trainingLevel = _currentUserData?.trainingLevel {
            return trainingLevel
        } else {
            return ""
        }
    }
    
    init(){
        findCurrentUser()
    }
    
    func updateCurrentUser() {
        findCurrentUser()
    }
    
    func findCurrentUser() -> UserData? {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "UserData") //datamodel name
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.users = results as! [UserData]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        for user in users {
            print("User last name: \(user.lastName)")
            if user.currentUser == true {
                _currentUserData = user
                print("Found current user")
                return user
            }
        }
        
        return nil
    }
    
    func setCurrentUser(newCurrentUser: UserData) {
        clearAllCurrentUsers()
        _currentUserData = newCurrentUser
        newCurrentUser.currentUser = true
    }
    
    func clearAllCurrentUsers(){
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "UserData") //datamodel name
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.users = results as! [UserData]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        for user in users {
            print("Clearing: \(user.lastName)")
            user.currentUser = false
        }
        
        do {
            try context.save()
        } catch {
            print("Could not save user")
        }
    }
    
    func printUsers(){
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "UserData") //datamodel name
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.users = results as! [UserData]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        print("Printing all users:")
        for user in users {
            print("User: \(user.firstName!) \(user.lastName!) Active:\(user.currentUser!)")
        }
    }
}

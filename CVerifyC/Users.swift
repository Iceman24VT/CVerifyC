//
//  Users.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/12/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Users  {
    private var _currentUserData: UserData!
    private var _currentUserIndex: Int!
    private var _app: AppDelegate!
    private var _context: NSManagedObjectContext!
    
    private var _users = [UserData]()
    
    init(){
        _app = UIApplication.sharedApplication().delegate as! AppDelegate
        _context = _app.managedObjectContext
        
        self.loadUserList()
        _currentUserData = self.findCurrentUser()
    }
    
    var currentUser: UserData? {
        return _currentUserData
    }
    
    var userList: [UserData]? {
        self.loadUserList()
        return _users
    }
    
    var count: Int! {
        return _users.count
    }
    
    func setCurrentUser(newCurrentUser: UserData) {
        _currentUserData = newCurrentUser
        _currentUserIndex = getIndexForUserId(newCurrentUser.userId!)
        newCurrentUser.currentUser = true
        clearAllOtherCurrentUsers(newCurrentUser.userId!)
        setUserList()
    }
    
    func addUserAndSetAsCurrent(user: UserData){
        addUser(user)
        setCurrentUser(user)
    }

    func addUserAndSetAsCurrent(firstName: String, lastName: String, institution: String, trainingLevel: String, percentComplete: NSNumber, currentUser: Bool) {
        
        var newUser: UserData!
        newUser = addUser(firstName, lastName: lastName, institution: institution, trainingLevel: trainingLevel, percentComplete: percentComplete, currentUser: true, tutorialComplete: false)
        setCurrentUser(newUser)
    }
    
    func addNewUser(user: UserData){
        addUser(user)
    }
    
    func printUsers(){
        print("Printing all users:")
        for user in _users {
            print("User: \(user.firstName!) \(user.lastName!) Active:\(user.currentUser!) Percent Compete: \(user.completionPercent) Iteration:\(user.iteration) Tutorial:\(user.tutorialComplete)")
        }
    }
    
    func updateCurrentPercentComplete(newPercentComplete: Double) {
        //printUsers()
        //print("New completion percent: \(newPercentComplete)")
        
        _users[_currentUserIndex].completionPercent = newPercentComplete
        setUserList()
        //printUsers()
    }
    
    func incrementCurrentIteration(){
        let currentIteration = _users[_currentUserIndex].iteration! as Int
        _users[_currentUserIndex].iteration =  NSNumber(int: currentIteration + 1)
        setUserList()
    }
    
    func tutorialCompleted(){
        _users[_currentUserIndex].tutorialComplete =  true
        setUserList()
    }
    
    private func addUser(user: UserData){
        let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: _context)!
        let userEntity = UserData(entity: entity, insertIntoManagedObjectContext: _context)
        
        userEntity.setToUser(user)
        
        _context.insertObject(user)
        
        setUserList()
    }
    
    private func addUser(firstName: String, lastName: String, institution: String, trainingLevel: String, percentComplete: NSNumber, currentUser: Bool, tutorialComplete: Bool) -> UserData {
        let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: _context)!
        let userEntity = UserData(entity: entity, insertIntoManagedObjectContext: _context)
        
        userEntity.firstName = firstName
        userEntity.lastName = lastName
        userEntity.institution = institution
        userEntity.trainingLevel = trainingLevel
        userEntity.completionPercent = percentComplete
        userEntity.currentUser = currentUser
        userEntity.iteration = 1
        userEntity.userId = NSUUID().UUIDString
        userEntity.tutorialComplete = tutorialComplete
        
        _context.insertObject(userEntity)
        
        setUserList()
        
        return userEntity
    }
    
    private func loadUserList(){
        let fetchRequest = NSFetchRequest(entityName: "UserData") //datamodel name
        
        do {
            let results = try _context.executeFetchRequest(fetchRequest)
            self._users = results as! [UserData]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    private func setUserList(){
        do {
            try _context.save()
        } catch {
            print("Could not save user")
        }
        
        loadUserList()
    }
    
    private func findCurrentUser() -> UserData? {
        for user in _users {
            print("User last name: \(user.lastName)")
            if user.currentUser == true {
                _currentUserData = user
                _currentUserIndex = getIndexForUserId(_currentUserData.userId!)
                print("Found current user")
                return user
            }
        }
        
        return nil
    }
    
    private func clearAllOtherCurrentUsers(newCurrId: String){
        print("cleaing All, but: newCurrID: \(newCurrId)")
        
        for user in _users {
            if user.userId != newCurrId {
                print("Clearing: \(user.lastName!), ID:\(user.userId!)")
                user.currentUser = false
            } else {
                print("Keeping: \(user.lastName!), ID:\(user.userId!)")
                user.currentUser = true
            }
        }
    }
    
    private func getIndexForUserId(userId: String) -> Int {
        for var x = 0; x < _users.count; x++ {
            if _users[x].userId == userId {
                return x
            }
        }
        
        print("Error finding index")
        return -1
    }
}

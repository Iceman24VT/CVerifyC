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
        newUser = addUser(firstName, lastName: lastName, institution: institution, trainingLevel: trainingLevel, percentComplete: percentComplete, currentUser: true)
        setCurrentUser(newUser)
    }
    
    func addNewUser(user: UserData){
        addUser(user)
    }
    
    func printUsers(){
        print("Printing all users:")
        for user in _users {
            print("User: \(user.firstName!) \(user.lastName!) Active:\(user.currentUser!)")
        }
    }
    
    private func addUser(user: UserData){
        let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: _context)!
        let userEntity = UserData(entity: entity, insertIntoManagedObjectContext: _context)
        
        userEntity.setToUser(user)
        
        _context.insertObject(user)
        
        setUserList()
    }
    
    private func addUser(firstName: String, lastName: String, institution: String, trainingLevel: String, percentComplete: NSNumber, currentUser: Bool) -> UserData {
        let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: _context)!
        let userEntity = UserData(entity: entity, insertIntoManagedObjectContext: _context)
        
        userEntity.firstName = firstName
        userEntity.lastName = lastName
        userEntity.institution = institution
        userEntity.trainingLevel = trainingLevel
        userEntity.completionPercent = percentComplete
        userEntity.currentUser = currentUser
        userEntity.userId = NSUUID().UUIDString
        
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
    }
    
    private func findCurrentUser() -> UserData? {
        for user in _users {
            print("User last name: \(user.lastName)")
            if user.currentUser == true {
                _currentUserData = user
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
}

//
//  UserData.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/9/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation
import CoreData


class UserData: NSManagedObject {
    func getPercentCompleteInt() -> Int! {
        var percentCompleteInt: Int!
        
        if let percentComplete = self.completionPercent where self.completionPercent != 0{
            percentCompleteInt = Int(percentComplete.doubleValue * 100.0)
            
        } else {
            percentCompleteInt = 0
        }
        
        return percentCompleteInt
    }
    
    func setToUser(newData: UserData){
        self.iteration = newData.iteration
        self.firstName = newData.firstName
        self.lastName = newData.lastName
        self.userId = newData.userId
        self.currentUser = newData.currentUser
        self.institution = newData.institution
        self.trainingLevel = newData.trainingLevel
        self.completionPercent = newData.completionPercent
        self.tutorialComplete = newData.tutorialComplete
    }
}

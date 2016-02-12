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
    func getPercentCompleteInt() -> Int? {
        var percentCompleteInt: Int!
        
        if let percentComplete = self.completionPercent where self.completionPercent != 0{
            percentCompleteInt = Int((percentComplete.doubleValue * 100.0)%1)
            
        } else {
            percentCompleteInt = 0
        }
        
        return percentCompleteInt
    }
}

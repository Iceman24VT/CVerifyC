//
//  UserMetrics+CoreDataProperties.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserMetrics {

    @NSManaged var userId: String?
    @NSManaged var questionNumber: NSNumber?
    @NSManaged var questionCorrect: NSNumber?
    @NSManaged var iteration: NSNumber?

}

//
//  UserData+CoreDataProperties.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserData {

    @NSManaged var completionPercent: NSNumber?
    @NSManaged var currentUser: NSNumber?
    @NSManaged var firstName: String?
    @NSManaged var institution: String?
    @NSManaged var lastName: String?
    @NSManaged var trainingLevel: String?
    @NSManaged var userId: String?

}

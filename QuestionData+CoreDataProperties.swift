//
//  QuestionData+CoreDataProperties.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/13/16.
//  Copyright © 2016 UVA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension QuestionData {

    @NSManaged var promptImgName: String?
    @NSManaged var maskImgName: String?
    @NSManaged var promptText: String?
    @NSManaged var correctResponseText: String?
    @NSManaged var incorrectResponseText: String?
    @NSManaged var typeOfQuestion: String?

}

//
//  CVC_Globals.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation

var users: Users!
var questions: Questions!
var metrics: Metrics!

enum QuestionStatus {
    case correct, incorrect, incomplete
}

let Question_Correct: Int = QuestionStatus.correct.hashValue
let Question_Incorrect: Int = QuestionStatus.incorrect.hashValue
let Question_Incomplete: Int = QuestionStatus.incomplete.hashValue

func stringForQuestionStatusHash(hashInt: Int) -> String {
    switch hashInt {
    case Question_Correct:
        return "Correct"
    case Question_Incorrect:
        return "Incorrect"
    case Question_Incomplete:
        return "Incomplete"
    default:
        return "Error, hash undefined"
    }
}

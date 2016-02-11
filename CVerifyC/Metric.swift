//
//  Metric.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/10/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import Foundation

class Metric {
    private var _question: Int?
    private var _time: NSTimeInterval?
    private var _correct: Int?
    private var _comment: String?
    
    var question: Int {
        if _question != nil {
            return _question!
        } else {
            return -1
        }
    }
    
    var time: NSTimeInterval {
        if _time != nil {
            return _time!
        } else {
            return -1
        }
    }
    
    var correct: Int {
        if _correct != nil {
            return _correct!
        } else {
            return -1
        }
    }
    
    var comment: String {
        get {
            if _comment != nil {
                return _comment!
            } else {
                return ""
            }
        }
        
        set {
            _comment = newValue
        }
    }
    
    init(ques: Int, time: NSTimeInterval, correct: Int){
        _question = ques
        _time = time
        _correct = correct
    }
}
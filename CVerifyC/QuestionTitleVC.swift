//
//  QuestionTitleVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class QuestionTitleVC: UIViewController {

    @IBOutlet weak var QuestionTitleLbl: UILabel!
    
    let TRANSITION_TIME:NSTimeInterval = 1.5
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        QuestionTitleLbl.text = "Question \(questions.getCurrentQuestionNumber())"
    }
    
    override func viewDidAppear(animated: Bool) {
        QuestionTitleLbl.text = "Question \(questions.getCurrentQuestionNumber())"
        
        //set up timer
        startTimer()
    }

    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(TRANSITION_TIME, target: self, selector: "transitionToQuestion", userInfo: nil, repeats: true)
    }
    
    func transitionToQuestion(){
        performSegueWithIdentifier("SegueTitleToQuestion", sender: nil)        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
}

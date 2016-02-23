//
//  CompleteVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/21/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class CompleteVC: UIViewController {

    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var sessionsCompleteLbl: UILabel!
    @IBOutlet weak var thisSessionCorrectLbl: UILabel!
    @IBOutlet weak var thisSessionIncorrectLbl: UILabel!
    @IBOutlet weak var thisSessionPercentCorrectLbl: UILabel!
    @IBOutlet weak var allSessionsCorrectLbl: UILabel!
    @IBOutlet weak var allSessionsIncorrectLbl: UILabel!
    @IBOutlet weak var allSessionsPercentCorrectLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        _updateResults()
        metrics.printAllMetrics()
        //users.incrementCurrentIteration()
    }

    @IBAction func homeBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("SegueCompleteToHome", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    private func _updateResults(){
        userInfoLbl.text = "\tUser name:  \(users.currentUser!.firstName!) \(users.currentUser!.lastName!)\n\tInstitution:  \(users.currentUser!.institution!)\n\tTraining level:  \(users.currentUser!.trainingLevel!)"
        
        sessionsCompleteLbl.text = "Number of training sessions completed:  \(users.currentUser!.iteration!)"
        
        thisSessionCorrectLbl.text = "Correct Answers:  \(metrics.getNumberCorrectSession(users.currentUser!.userId!, iteration: users.currentUser!.iteration!))"
        thisSessionIncorrectLbl.text = "Incorrect Answers:  \(metrics.getNumberIncorrectSession(users.currentUser!.userId!, iteration: users.currentUser!.iteration!))"
        thisSessionPercentCorrectLbl.text = "\(Int(metrics.getPercentCorrectForUserIdSession(users.currentUser!.userId!, iteration: users.currentUser!.iteration!)*100))% Correct"
        
        allSessionsCorrectLbl.text = "Correct Answers:  \(metrics.getNumberCorrect(users.currentUser!.userId!))"
        allSessionsIncorrectLbl.text = "Incorrect Answers:  \(metrics.getNumberIncorrect(users.currentUser!.userId!))"
        allSessionsPercentCorrectLbl.text = "\(Int(metrics.getPercentCorrectForUserId(users.currentUser!.userId!)*100))% Correct"
    }
}

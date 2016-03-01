//
//  ViewController.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/9/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {


    @IBOutlet weak var userNameBtn: UIButton!
    @IBOutlet weak var addUserBtn: RoundButton!
    @IBOutlet weak var changeUserBtn: RoundButton!
    @IBOutlet weak var startTutorialBtn: UIButton!
    @IBOutlet weak var startTrainingBtn: UIButton!
    @IBOutlet weak var percentTrainingCompletedLbl: UILabel!
    
    private var _userSelected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize and find currentUser
        if users == nil {
            users = Users.init()
        }
        if questions == nil {
            questions = Questions.init()
        }
        if metrics == nil {
            metrics = Metrics.init()
        }
        
        //check for there are registered users, if not set defaults User and inactivate tutorial
        // and training buttons; else activate buttons
        if users.currentUser != nil {
            _userSelected = true
            updateVCUserSelected()
        } else {
            _userSelected = false
            updateVCUserNotSelected()
        }
    }

    override func viewDidAppear(animated: Bool) {
        print("View did appear")
        users!.printUsers()
        
        if _userSelected == true {
            updateVCUserSelected()
        } else {
            updateVCUserNotSelected()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func userNameBtnPressed(sender: AnyObject) {
        if _userSelected == true {
            performSegueWithIdentifier("SegueHomeToUserSelection", sender: nil)
        } else {
            performSegueWithIdentifier("SegueHomeToLogin", sender: nil)
        }
    }
    
    @IBAction func addUserBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("SegueHomeToLogin", sender: nil)
    }
    
    @IBAction func changeUserBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("SegueHomeToUserSelection", sender: nil)
    }
    
    @IBAction func startTutorialBtnPressed(sender: AnyObject) {
        if _userSelected! {
            performSegueWithIdentifier("SegueHomeToTutorial", sender: nil)
        }
    }
    
    @IBAction func startTrainingBtnPressed(sender: AnyObject) {
        if _userSelected == true {
            if users.currentUser!.getPercentCompleteInt() == 100 {
                users.incrementCurrentIteration()
            }
            
            questions.findNextQuestion((users.currentUser?.userId)!, iterationNum: (users.currentUser?.iteration)!)
            performSegueWithIdentifier("SegueHomeToQuestionTitle", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueHomeToLogin" {
            print("seguing to login")
        } else if segue.identifier == "SegueHomeToUserSelection" {
            print("seguing to selection")
        } else if segue.identifier == "SegueHomeToQuestion" {
            print("seguing to question")
        }
    }
    
    func updateVCUserSelected() {
        //update user info
        userNameBtn.setTitle("User: \(users.currentUser!.firstName!.capitalizedString) \(users!.currentUser!.lastName!.capitalizedString)", forState: .Normal)
        percentTrainingCompletedLbl.text = "\(users.currentUser!.getPercentCompleteInt())% Complete"
        
        if metrics.userAnsweredAnyQuestions(users.currentUser!.userId!) {
            if users.currentUser!.getPercentCompleteInt() == 100 {
                startTrainingBtn.setTitle("Repeat training session", forState: .Normal)
            } else {
                startTrainingBtn.setTitle("Continue training session", forState: .Normal)
            }
        } else {
            startTrainingBtn.setTitle("Start training session", forState: .Normal)
        }
        
        if users.currentUser!.tutorialComplete == false {
            startTrainingBtn.alpha = 0.5
            startTrainingBtn.enabled = false
        } else {
            startTrainingBtn.alpha = 1.0
            startTrainingBtn.enabled = true
        }
        
        //activate buttons
        changeUserBtn.alpha = 1.0
        changeUserBtn.enabled = true
        startTutorialBtn.alpha = 1.0
        startTutorialBtn.enabled = true
    }
    
    func updateVCUserNotSelected() {
        //default text
        userNameBtn.setTitle("User: None logged in [Add new user to continue]", forState: .Normal)
        percentTrainingCompletedLbl.text = "0% Complete"
        
        //inactivate buttons
        //addUser_changeUserBtn.setTitle("Add User", forState: .Normal)
        changeUserBtn.alpha = 0.5
        changeUserBtn.enabled = false
        startTutorialBtn.alpha = 0.5
        startTutorialBtn.enabled = false
        startTrainingBtn.alpha = 0.5
        startTrainingBtn.enabled = false
    }
}


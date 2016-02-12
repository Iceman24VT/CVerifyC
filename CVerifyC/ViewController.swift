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


    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var addUser_changeUserBtn: UIButton!
    @IBOutlet weak var startTutorialBtn: UIButton!
    @IBOutlet weak var startTrainingBtn: UIButton!
    @IBOutlet weak var percentTrainingCompletedLbl: UILabel!
    
    private var _userSelected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize and find currentUser
        currentUser = CurrentUserData.init()
        currentUser!.printUsers()
        
        //check for there are registered users, if not set defaults User and inactivate tutorial
        // and training buttons; else activate buttons
        if currentUser!.currentUser != nil {
            _userSelected = true
            updateVCUserSelected()
        } else {
            _userSelected = false
            updateVCUserNotSelected()
        }
    }

    override func viewDidAppear(animated: Bool) {
        print("View did appear")
        currentUser!.printUsers()
        updateVCUserSelected()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addUser_changeUserBtnPressed(sender: AnyObject) {
        if _userSelected! {
            performSegueWithIdentifier("SegueHomeToUserSelection", sender: nil)
        } else {
            performSegueWithIdentifier("SegueHomeToLogin", sender: nil)
        }
        
    }

    @IBAction func startTutorialBtnPressed(sender: AnyObject) {
    }
    
    @IBAction func startTrainingBtnPressed(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueHomeToLogin" {
            print("seguing to login")
        } else if segue.identifier == "SegueHomeToUserSelection" {
            print("seguing to selection")
        }
    }
    
    func updateVCUserSelected() {
        //update user info
        userNameLbl.text = "User: \(currentUser!.firstName.capitalizedString) \(currentUser!.lastName)"
        percentTrainingCompletedLbl.text = "\(currentUser!.percentComplete)% Complete"
        
        //activate buttons
        addUser_changeUserBtn.setTitle("Change User", forState: .Normal)
        startTutorialBtn.alpha = 1.0
        startTutorialBtn.enabled = true
        startTrainingBtn.alpha = 1.0
        startTrainingBtn.enabled = true
    }
    
    func updateVCUserNotSelected() {
        //default text
        userNameLbl.text = "User: None logged in [Add new user to continue]"
        percentTrainingCompletedLbl.text = "0% Complete"
        
        //inactivate buttons
        addUser_changeUserBtn.setTitle("Add User", forState: .Normal)
        startTutorialBtn.alpha = 0.5
        startTutorialBtn.enabled = false
        startTrainingBtn.alpha = 0.5
        startTrainingBtn.enabled = false
    }
}


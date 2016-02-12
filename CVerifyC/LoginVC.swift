//
//  LoginVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/9/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: UIViewController {

    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var institutionTxt: UITextField!
    @IBOutlet weak var trainingLevelTxt: UITextField!
    
    @IBOutlet weak var firstNameWarningLbl: UILabel!
    @IBOutlet weak var lastNameWarningLbl: UILabel!
    @IBOutlet weak var institutionWarningLbl: UILabel!
    @IBOutlet weak var trainingLevelWarningLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameWarningLbl.hidden = true
        lastNameWarningLbl.hidden = true
        institutionWarningLbl.hidden = true
        trainingLevelWarningLbl.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitBtnPressed(sender: AnyObject) {
        if dataComplete() {
            print("User data complete")
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("UserData", inManagedObjectContext: context)!
            let user = UserData(entity: entity, insertIntoManagedObjectContext: context)
            
            user.firstName = firstNameTxt.text
            user.lastName = lastNameTxt.text
            user.institution = institutionTxt.text
            user.trainingLevel = trainingLevelTxt.text
            user.userId = NSTimeIntervalSince1970
            user.currentUser = true
            
            currentUser!.setCurrentUser(user)
            
            context.insertObject(user)
            
            do {
                try context.save()
            } catch {
                print("Could not save user")
            }
            
            //segue back to main screen
            performSegueWithIdentifier("SegueLoginToHome", sender: nil)
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        //tranisition back to previous screen, this may be main menu
        // on first run or user selection on subsequent runs
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dataComplete() -> Bool {
        var dataComplete: Bool = true
        
        if firstNameTxt.text == "" {
            dataComplete = false
            firstNameWarningLbl.hidden = false
        } else {
            firstNameWarningLbl.hidden = true
        }
        if lastNameTxt.text == "" {
            dataComplete = false
            lastNameWarningLbl.hidden = false
        } else {
            lastNameWarningLbl.hidden = true
        }
        if institutionTxt.text == "" {
            dataComplete = false
            institutionWarningLbl.hidden = false
        } else {
            institutionWarningLbl.hidden = true
        }
        if trainingLevelTxt.text == "" {
            dataComplete = false
            trainingLevelWarningLbl.hidden = false
        } else {
            trainingLevelWarningLbl.hidden = true
        }
        
        return dataComplete
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueLoginToHome" {
            print("seguing to home")
        }
    }


}

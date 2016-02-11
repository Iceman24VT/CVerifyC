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
    
    private var _userSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //check for there are registered users, if not set defaults User and inactivate tutorial
        // and training buttons; else activate buttons
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addUser_changeUserBtnPressed(sender: AnyObject) {
        if _userSelected {
            
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
            print("seguing")
        }
    }
}


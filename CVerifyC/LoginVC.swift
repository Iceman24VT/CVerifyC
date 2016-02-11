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
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
//    var fetchedResultsController: NSFetchedResultsController!
//        let app = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context = app.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "UserData")
//        
//        do {
//            let results = try context.executeFetchRequest(fetchRequest)
//            let uData = results[0] as! UserData
//            
//            if let metricOut = uData.metrics as? Metric {
//                print(metricOut.comment)
//            }
//            
//        } catch let err as NSError {
//            print(err.debugDescription)
//        } catch  {
//            print("Let error")
//        }
}

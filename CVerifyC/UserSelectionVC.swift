//
//  UserSelectionVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/11/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit
import CoreData

class UserSelectionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userTableView: UITableView!
    
    var users = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    

    override func viewDidAppear(animated: Bool) {
        fetchAndSetUsers()
        userTableView.reloadData()
    }
    
    //table view functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as? UserCell{
            
            let user = users[indexPath.row]
            cell.configureCell(user)
            return cell
        } else {
            UserCell()
        }
        
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Changing user")
        if indexPath.row <= users.count{
            currentUser?.setCurrentUser(users[indexPath.row])
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //end table view function
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func newUserBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("SegueUserSelectionToLogin", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func fetchAndSetUsers () {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "UserData") //datamodel name
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.users = results as! [UserData]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

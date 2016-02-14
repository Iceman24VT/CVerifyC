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
    
    var usersList = [UserData]()
    
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
            
            let user = usersList[indexPath.row]
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
        return usersList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Changing user")
        if indexPath.row <= usersList.count{
            users!.setCurrentUser(usersList[indexPath.row])
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
        if let newList = users?.userList{
            usersList = newList
        } else {
            print("User list did not load")
        }
    }
}

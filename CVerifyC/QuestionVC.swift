//
//  QuestionVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/13/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var imgScrollView: QuestionScrollView!
    
    private var _screenSize: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _screenSize = UIScreen.mainScreen().bounds
        imgScrollView.delegate = imgScrollView       
        let image = UIImage(named: "normal_CXR_lrg")
        imgScrollView.setupImage(_screenSize, scrollOrigin: CGPoint(x: 0.0, y: 0.0), scrollImage: image!)
    }
    
    @IBAction func promptBtnPressed(sender: AnyObject) {
    }
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
        //segue back to main screen
        performSegueWithIdentifier("SegueQuestionToHome", sender: nil)
    }
    
    @IBAction func resetBtnPressed(sender: AnyObject) {
        imgScrollView.resetView()        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueQuestionToHome" {
            print("seguing to Home")
        }
    }
}

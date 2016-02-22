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
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var fullScreenBtn: UIButton!
    @IBOutlet weak var communicationLbl: RoundLabel!
    @IBOutlet weak var promptBtn: UIButton!
    @IBOutlet weak var submitBtn: RoundButton!
    
    @IBOutlet weak var nextQuestionBtn: RoundButton!
    enum QuestionMode {
        case Prompt, UserSelect, AnswerDisplay
    }
    
    private var _screenSize: CGRect!
    private var _mode: QuestionMode!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        _screenSize = UIScreen.mainScreen().bounds
        imgScrollView.delegate = imgScrollView
        let image = questions.getCurrentQuestionImage()
        //let image = questions.getCurrentQuestionMask()
        imgScrollView.setupImage(_screenSize, scrollOrigin: CGPoint(x: 0.0, y: 0.0), scrollImage: image)
        
        communicationLbl.hidden = false
        communicationLbl.text = "\(questions.getCurrentQuestionPrompt())\n\n[Touch anywhere to continue]"
        fullScreenBtn.enabled = true
        promptBtn.hidden = true
        submitBtn.hidden = true
        nextQuestionBtn.hidden = true
        
        _mode = .Prompt
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "arrowPlacedOnScrollView:", name: "arrowPlaced", object: nil)
    }
    
    func arrowPlacedOnScrollView(notif: AnyObject){
        submitBtn.hidden = false
    }
    
    @IBAction func promptBtnPressed(sender: AnyObject) {
        if _mode == .UserSelect {
            communicationLbl.hidden = false
            fullScreenBtn.enabled = true
            promptBtn.hidden = true
            _mode = .Prompt
            
        } else if _mode == .AnswerDisplay {
            communicationLbl.hidden = false
            fullScreenBtn.enabled = true
            promptBtn.hidden = true
        }
    }
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
        if _mode == .AnswerDisplay {
            if questions.goToNextQuestion() == false {
                performSegueWithIdentifier("SegueQuestionToComplete", sender: nil)
            }
        }
        
        //segue back to main screen
        performSegueWithIdentifier("SegueQuestionToHome", sender: nil)
    }
    
    @IBAction func resetBtnPressed(sender: AnyObject) {
        imgScrollView.resetView()
        brightnessSlider.value = 0.5
        contrastSlider.value = 0.5
        imgScrollView.changeBrightness(0.5)
        imgScrollView.changeContrast(0.5)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueQuestionToHome" {
            print("seguing to Home")
        }
    }

    @IBAction func fullScreenBtnPressed(sender: UIButton) {
        if _mode == .Prompt {
            communicationLbl.hidden = true
            fullScreenBtn.enabled = false
            promptBtn.hidden = false
            _mode = .UserSelect
        } else if _mode == .AnswerDisplay {
            communicationLbl.hidden = true
            fullScreenBtn.enabled = false
            promptBtn.hidden = false
        }
    }
    
    @IBAction func SubmitBtnPressed(sender: AnyObject) {
        submitBtn.hidden = false
        
        if questions.currentSubmissionCorrect(imgScrollView.arrowPosition!) {
            print("Correct submission")
            communicationLbl.text = "\(questions.getCurrentCorrectResponse())\n\n[Touch anywhere to dismiss this window]"
        } else {
            print("Incorrect submission")
            communicationLbl.text = "\(questions.getCurrentIncorrectResponse())\n\n[Touch anywhere to dismiss this window]"
        }
        
        imgScrollView.displayMask(questions.getCurrentQuestionMask())
        communicationLbl.hidden = false
        promptBtn.hidden = true
        submitBtn.hidden = true
        fullScreenBtn.enabled = true
        nextQuestionBtn.hidden = false
        
        _mode = .AnswerDisplay
    }
    
    @IBAction func nextQuestionBtnPressed(sender: AnyObject) {
        if questions.goToNextQuestion() == true {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("SegueQuestionToComplete", sender: nil)
        }
    }
    
    @IBAction func brightnessSliderChanged(sender: UISlider) {
        print("Brightness: \(sender.value)")
        imgScrollView.changeBrightness(sender.value)
    }
    
    @IBAction func contrastSliderChanged(sender: UISlider) {
        print("Contrast: \(sender.value)")
        imgScrollView.changeContrast(sender.value)
    }
}

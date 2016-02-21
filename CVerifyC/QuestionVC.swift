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
        imgScrollView.setupImage(_screenSize, scrollOrigin: CGPoint(x: 0.0, y: 0.0), scrollImage: image)
        
        communicationLbl.hidden = false
        communicationLbl.text = "\(questions.getCurrentQuestionPrompt())\n[Touch anywhere to continue]"
        fullScreenBtn.enabled = true
        promptBtn.hidden = true
        submitBtn.hidden = true
        
        _mode = .Prompt
    }
    
    @IBAction func promptBtnPressed(sender: AnyObject) {
        if _mode == .UserSelect {
            communicationLbl.hidden = false
            fullScreenBtn.enabled = true
            promptBtn.hidden = true
            _mode = .Prompt
        }
    }
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
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
        }
    }
    
    @IBAction func SubmitBtnPressed(sender: AnyObject) {
        
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

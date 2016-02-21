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
    
    private var _screenSize: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _screenSize = UIScreen.mainScreen().bounds
        imgScrollView.delegate = imgScrollView       
        let image = questions.getCurrentQuestionImage()
        imgScrollView.setupImage(_screenSize, scrollOrigin: CGPoint(x: 0.0, y: 0.0), scrollImage: image)
    }
    
    @IBAction func promptBtnPressed(sender: AnyObject) {
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

    @IBAction func brightnessSliderChanged(sender: UISlider) {
        print("Brightness: \(sender.value)")
        imgScrollView.changeBrightness(sender.value)
    }
    
    @IBAction func contrastSliderChanged(sender: UISlider) {
        print("Contrast: \(sender.value)")
        imgScrollView.changeContrast(sender.value)
    }
}

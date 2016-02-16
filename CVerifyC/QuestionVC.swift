//
//  QuestionVC.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/13/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var imgScrollView: UIScrollView!
    
    private var _baseZoomRatio: CGFloat!
    private var _screenSize: CGRect!
    private var _img: UIImage!
    private var _imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _img = UIImage(named: "normal_CXR_lrg")
        _imgView = UIImageView(image: _img)
        _screenSize = UIScreen.mainScreen().bounds
        imgScrollView.addSubview(_imgView)
        
        determineBaseZoom()
        _imgView.frame = CGRectMake(0,0, _img.size.width * _baseZoomRatio, _img.size.height * _baseZoomRatio)
        imgScrollView.contentSize = _img.size
        print("imgScrollView.maximumZoomScale: \(imgScrollView.maximumZoomScale)")
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        imgScrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // 4
        let scrollViewFrame = imgScrollView.frame
        let scaleWidth = scrollViewFrame.size.width / imgScrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / imgScrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        imgScrollView.minimumZoomScale = minScale;
        
        // 5
        imgScrollView.maximumZoomScale = 5.0
        imgScrollView.zoomScale = minScale;
        
        // 6
        centerScrollViewContents()
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(_imgView)
        print("imgScrollView.maximumZoomScale: \(imgScrollView.maximumZoomScale)")
        print("imgScrollView.minimumZoomScale: \(imgScrollView.minimumZoomScale)")
        //imgScrollView.maximumZoomScale = CGFloat(5.0)
        
        // 2
        var newZoomScale = imgScrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, imgScrollView.maximumZoomScale)

        // 3
        let scrollViewSize = imgScrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        imgScrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func centerScrollViewContents() {
        let boundsSize = imgScrollView.bounds.size
        var contentsFrame = _imgView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        _imgView.frame = contentsFrame
    }
    
    func determineBaseZoom(){
        let baseZoomRatioHgt = _screenSize.height/_img.size.height
        let baseZoomRatioWdt = _screenSize.width/_img.size.width
        
        if baseZoomRatioHgt < baseZoomRatioWdt {
            _baseZoomRatio = baseZoomRatioHgt
        } else {
            _baseZoomRatio = baseZoomRatioWdt
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return _imgView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
        
    }

    @IBAction func promptBtnPressed(sender: AnyObject) {
    }
}

//
//  QuestionScrollView.swift
//  CVerifyC
//
//  Created by Thomas Hartka on 2/16/16.
//  Copyright © 2016 UVA. All rights reserved.
//

import UIKit

class QuestionScrollView: UIScrollView, UIScrollViewDelegate {
    private var _scrollViewFrame: CGRect!
    private var _imgView: UIImageView!
    private var _defaultZoom: CGFloat!
    private var _arrowPlaced: Bool!
    private var _arrowImageView: UIImageView?
    private var _arrowPosition: CGPoint?
    private var _filterContext: CIContext!
    private var _contrastFilter: CIFilter!
    private var _brightnessFilter: CIFilter!
    private var _beginImage: CIImage!
    
    var arrowPosition: CGPoint? {
        return _arrowPosition
    }
    
    var arrowPlaced: Bool! {
        return _arrowPlaced
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupImage(scrollFrame: CGRect, scrollOrigin: CGPoint, scrollImage: UIImage) {
        _scrollViewFrame = scrollFrame
        _arrowPlaced = false
        
        self.frame = scrollFrame
        self.bounds = scrollFrame
        
        // 3
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewSingleTapped:")
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        singleTapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTapRecognizer)
        
        let image = scrollImage
        _imgView = UIImageView(image: image)
        let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        //let imageBounds = _imgView.bounds
        _imgView.frame = imageFrame
        self.addSubview(_imgView)
        
        // 2
        self.contentSize = image.size

        // 4
        let scrollViewFrame = self.frame
        let scaleWidth = scrollViewFrame.size.width / self.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / self.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        _defaultZoom = minScale
        self.minimumZoomScale = minScale;
        
        // 5
        self.maximumZoomScale = MAX_QUESTION_ZOOM
        self.zoomScale = minScale;
        
        _beginImage = CIImage(image: scrollImage)
        _filterContext = CIContext(options:nil)
        //_contrastFilter = CIFilter(name: "CISepiaTone")
        _contrastFilter = CIFilter(name: "CIColorControls")
        _contrastFilter.setValue(_beginImage, forKey: kCIInputImageKey)
        if let contrastValue = _contrastFilter.valueForKey(kCIInputContrastKey) as? NSNumber{
            print("ContrastValue: \(contrastValue)")
        }
        if let brightnessValue = _contrastFilter.valueForKey(kCIInputBrightnessKey) as? NSNumber{
            print("BrightnessValue: \(brightnessValue)")
        }
        //_contrastFilter.setValue(0.5, forKey: kCIInputIntensityKey)
        _contrastFilter.setValue(0.5, forKey: kCIInputContrastKey)
        
        let outputImage = _contrastFilter.outputImage
        
        _filterContext = CIContext(options:nil)
        //let cgimg = _contrastFilter.createCGImage(outputImage, fromRect: outputImage.extent())
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetView(){
        self.zoomScale = _defaultZoom
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = self.bounds.size
        //let boundsSize = _screenSize
        var contentsFrame = _imgView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
            //contentsFrame.origin.y = 0.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        _imgView.frame = contentsFrame
        _contrastFilter = CIFilter(name: "CISepiaTone")
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        print("Double tap")
        
        // 1
        let pointInView = recognizer.locationInView(_imgView)
        
        // 2
        var newZoomScale = self.zoomScale * DOUBLE_TAP_QUESTION_ZOOM
        newZoomScale = min(newZoomScale, self.maximumZoomScale)
        print("imgScrollView.maximumZoomScale: \(self.maximumZoomScale)")
        print("imgScrollView.minimumZoomScale: \(self.minimumZoomScale)")
        
        // 3
        let scrollViewSize = self.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        self.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func scrollViewSingleTapped(recognizer: UITapGestureRecognizer){
        _arrowPosition = recognizer.locationInView(_imgView)
        let pointInScrollView = recognizer.locationInView(self)
        print("Single tap, imageView x:\(_arrowPosition!.x) y:\(_arrowPosition!.y)")
        print("Single tap, scrollView x:\(pointInScrollView.x) y:\(pointInScrollView.y)")
        
        if _arrowPlaced == false {
            let arrowImage = UIImage(named: "red-arrow-diagonal")
            let arrowFrame = CGRect(x: _arrowPosition!.x, y: _arrowPosition!.y, width: (arrowImage?.size.width)!, height: (arrowImage?.size.height)!)
            _arrowImageView = UIImageView.init(image: arrowImage)
            _arrowImageView!.frame = arrowFrame
            //self.addSubview(_arrowImageView!)
            _imgView.addSubview(_arrowImageView!)
            
            _arrowPlaced = true
        } else {
            _arrowImageView!.frame.origin.x = _arrowPosition!.x
            _arrowImageView!.frame.origin.y = _arrowPosition!.y
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return _imgView
        //return _arrowImageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func changeContrast(newContrast: Float!) {
        //_contrastFilter.setValue(newContrast, forKey: kCIInputIntensityKey)
        _contrastFilter.setValue(newContrast + 0.5, forKey: kCIInputContrastKey)
        if let outputImage = _contrastFilter.outputImage {
            let cgimg = _filterContext.createCGImage(outputImage, fromRect: outputImage.extent)
        
            let newImage = UIImage(CGImage: cgimg)
            _imgView.image = newImage
        }
    }
    
    func changeBrightness(newBrightness: Float!) {
        //_contrastFilter.setValue(newBrightness - 0.5, forKey: kCIInputBrightnessKey)
        _contrastFilter.setValue(newBrightness - 0.5, forKey: kCIInputSaturationKey)
        if let outputImage = _contrastFilter.outputImage {
            let cgimg = _filterContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            let newImage = UIImage(CGImage: cgimg)
            _imgView.image = newImage
        }
    }
}

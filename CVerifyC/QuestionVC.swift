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
    
    private var _screenSize: CGRect!
    private var _imgView: UIImageView!
    
    override func viewDidLoad() {
    
    //override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        _screenSize = UIScreen.mainScreen().bounds
        imgScrollView.frame = _screenSize
        imgScrollView.bounds = _screenSize
        
        // 1
        let image = UIImage(named: "normal_CXR")!
        _imgView = UIImageView(image: image)
        let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        //let imageBounds = _imgView.bounds
        _imgView.frame = imageFrame
        imgScrollView.addSubview(_imgView)
        
        // 2
        imgScrollView.contentSize = image.size
        
        // 3
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        imgScrollView.addGestureRecognizer(doubleTapRecognizer)
        
        //let imgScrollViewOrigin = imgScrollView.contentOffset
        
        // 4
        let imgScrollViewFrame = imgScrollView.frame
        let scaleWidth = imgScrollViewFrame.size.width / imgScrollView.contentSize.width
        let scaleHeight = imgScrollViewFrame.size.height / imgScrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        imgScrollView.minimumZoomScale = minScale;
        
        // 5
        imgScrollView.maximumZoomScale = 5.0
        imgScrollView.zoomScale = minScale;
    }
    
    func centerScrollViewContents() {
        let boundsSize = imgScrollView.bounds.size
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
        
        //imgScrollView.contentOffset = CGPoint(x: CGFloat(0.0),y: CGFloat(-300.0))
        
        _imgView.frame = contentsFrame
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(_imgView)
        
        // 2
        var newZoomScale = imgScrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, imgScrollView.maximumZoomScale)
        print("imgScrollView.maximumZoomScale: \(imgScrollView.maximumZoomScale)")
        print("imgScrollView.minimumZoomScale: \(imgScrollView.minimumZoomScale)")
        
        // 3
        let imgScrollViewSize = imgScrollView.bounds.size
        let w = imgScrollViewSize.width / newZoomScale
        let h = imgScrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        imgScrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return _imgView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}

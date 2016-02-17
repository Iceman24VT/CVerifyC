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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    func setupImage(scrollFrame: CGRect, scrollOrigin: CGPoint, scrollImage: UIImage) {
        _scrollViewFrame = scrollFrame
        
        self.frame = scrollFrame
        self.bounds = scrollFrame
        
        // 3
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTapRecognizer)
        
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
        self.maximumZoomScale = 5.0
        self.zoomScale = minScale;
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
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(_imgView)
        
        // 2
        var newZoomScale = self.zoomScale * 1.5
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
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return _imgView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}

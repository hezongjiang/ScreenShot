//
//  UIView+Extension.swift
//  SCreen
//
//  Created by he on 2017/8/18.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 截屏
    ///
    /// - Parameters:
    ///   - frame: 需要截取的范围，若为nil，则为视图的大小
    func screenshot(frame: CGRect? = nil) -> UIImage? {
        
        if let scrollView = self as? UIScrollView {
            
            return scrollViewScreenShot(scrollView, frame: frame)
            
        } else if let webView = self as? UIWebView {
          
            let scrollView = webView.scrollView
            
            return scrollViewScreenShot(scrollView, frame: frame)
            
        } else {
            
            let shotFrame: CGRect = (frame == nil) ? self.bounds : frame!
            
            UIGraphicsBeginImageContextWithOptions(shotFrame.size, true, 0)
            
            guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
            
            currentContext.translateBy(x: -shotFrame.origin.x, y: -shotFrame.origin.y)
            
            let path = UIBezierPath(rect: shotFrame)
            
            path.addClip()
            
            layer.render(in: currentContext)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image
        }
    }
    
    
    /// 截取scrollView的内容
    ///
    /// - Parameters:
    ///   - scrollView: scrollView
    ///   - frame: 截取范围
    /// - Returns: 截取的图片
    private func scrollViewScreenShot(_ scrollView: UIScrollView, frame: CGRect?) -> UIImage? {
        
        let shotFrame: CGRect = (frame == nil) ? CGRect(origin: CGPoint(), size: scrollView.contentSize) : frame!
        
        UIGraphicsBeginImageContextWithOptions(shotFrame.size, false, 0)
        
        let savedContentOffset = scrollView.contentOffset
        
        let savedFrame = scrollView.frame
        
        scrollView.contentOffset = CGPoint()
        
        scrollView.frame = CGRect(origin: CGPoint(), size: scrollView.contentSize)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        
        currentContext.translateBy(x: -shotFrame.origin.x, y: -shotFrame.origin.y)
        
        let path = UIBezierPath(rect: shotFrame)
        
        path.addClip()
        
        scrollView.layer.render(in: currentContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        scrollView.contentOffset = savedContentOffset
        
        scrollView.frame = savedFrame
        
        return image
    }
}

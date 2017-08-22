//
//  ImageViewController.swift
//  ScreenshotDemo
//
//  Created by he on 2017/8/22.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    var image: UIImage?
    
    fileprivate lazy var imageView: UIImageView = {
        
        return UIImageView(image: self.image)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        
        // 缩放比例
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 0.1;
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
    

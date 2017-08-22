//
//  ViewController.swift
//  ScreenshotDemo
//
//  Created by he on 2017/8/22.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    fileprivate lazy var photoFrame: UIImageView = {
       
        let imageView = UIImageView(frame: CGRect(x: self.view.bounds.width - 80, y: 300, width: 80, height: 110))
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowOpacity = 0.7
        
        imageView.isUserInteractionEnabled = true
        
        imageView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        imageView.addGestureRecognizer(tap)
        
        return imageView
        
    }()
    
    func click() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "picture") as! ImageViewController
        let addImage = UIImage(named: "my_logo")!
        
        // 截图，并且添加水印
        vc.image = webView.screenshot()?.addImage(addImage, atFrame: CGRect(origin: CGPoint(), size: addImage.size))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 监听屏幕截图
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil)
        
        view.addSubview(photoFrame)
        
        webView.loadRequest(URLRequest(url: URL(string: "https://www.jianshu.com/u/5fa5459c7b02")!))
    }
    
    func notify(_ noti: Notification) {
        
        let thumbnail = view.screenshot()
        photoFrame.image = thumbnail
        photoFrame.isHidden = false
        
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.photoFrame.frame.origin.y = 250
        }, completion: nil)
    }
}


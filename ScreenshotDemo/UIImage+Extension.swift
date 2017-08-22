//
//  UIImage+Extension.swift
//  SCreen
//
//  Created by he on 2017/8/22.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 给当前图片添加另一张图片
    ///
    /// - Parameters:
    ///   - image: 需要添加的图片
    ///   - frame: 添加图片的位置
    /// - Returns: 添加后的新图片
    func addImage(_ image: UIImage?, atFrame frame: CGRect) -> UIImage? {
        
        if image == nil { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        draw(in: CGRect(origin: CGPoint(), size: size))
        
        image?.draw(in: frame)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
}

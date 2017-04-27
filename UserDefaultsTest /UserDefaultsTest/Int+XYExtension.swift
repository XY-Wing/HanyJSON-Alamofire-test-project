//
//  Int+XYExtension.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/26.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import Foundation
import UIKit
extension Int {
    func isIn(ints: Int...) -> Bool {
        return ints.contains(self)
    }
}
extension UIView {
    func haha<T>(ints: T) -> UIView {
        return self
    }
}
extension UIBarButtonItem{
    
    /**
     返回一个UIBarButtonItem
     
     - parameter imageName: 图片名称
     - parameter target:    目标
     - parameter action:    监听方法
     
     - returns: UIBarButtonItem
     */
    
    // 如果在func前面加上"class"，就相当于OC中的 +
    class func createBarButtonItem(imageName:String, target:AnyObject, action:Selector) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: imageName), for: UIControlState.highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
}

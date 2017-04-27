//
//  XYConst.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/24.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import Foundation
import UIKit
public let kThing: String = "thing"

//MARK: - 屏幕宽／高
extension UIScreen {
    public static var XYScreenWidth: Double {
        return Double(UIScreen.main.bounds.size.width)
    }
    public static var XYScreenHeight: Double {
        return Double(UIScreen.main.bounds.size.height)
    }
}

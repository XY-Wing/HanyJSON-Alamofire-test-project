//
//  Student.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/24.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit

protocol Score {
    var math: Double { get set }
    var english: Double { get set }
    func mathPercent() -> String
}
extension Score {
    func mathPercent() -> String{
        let str = String(format: "%.2f", math / (math + english))
        return str
    }
}

class Student:NSObject, Score {
    var math = 0.0
    var english = 0.0
    
    init(math: Double, english: Double) {
        self.math = math
        self.english = english
    }

}

//
//  Car.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/24.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit

struct Car {
    var level: String = ""
    var name: String = "" {
        willSet {
            print(name)
        }
    }
    var price: Double = 0.0{
        willSet {
            if newValue > 300000 {
                self.level = "高级豪华车"
            } else {
                self.level = "普通家用车"
            }
        }
    }
    
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
        
        let i = 10
        changeInstance(i)
        print(i)
    }
    
    private func changeInstance(_ i:  Int) {
        var a = i
        a = a + 1
    }
    
}

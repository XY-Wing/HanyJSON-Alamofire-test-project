//
//  XYDefaults.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/24.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import Foundation
//MARK: - UserDefaultSettable协议
public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}
public extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {

}
//MARK: - UserDefaults扩展
extension UserDefaults {
    enum TestData {
        case name
    }
}

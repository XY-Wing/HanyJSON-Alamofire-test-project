//
//  Stack
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/26.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit
//push pop isEmpty peek size
class Stack {
    var stack: [Any]
    ///初始化
    init() {
        stack = [Any]()
    }
    //MARK: --- push
    func push(element: Any...) {
        stack.append(element)
    }
    //MARK: --- pop
    func pop() -> Any? {
        if !isEmpty() {
           return stack.removeLast()
        } else {
            return nil
        }
    }
    //MARK: --- isEmpty
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
    //MARK: --- peek
    func peek() -> Any? {
        return stack.last
    }
    //MARK: --- size
    func size() -> Int {
        return stack.count
    }
    
}


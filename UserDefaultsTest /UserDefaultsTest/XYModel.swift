//
//  XYModel.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/27.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit
import HandyJSON
class XYModel: HandyJSON {
    var code: Int = 1
    var data: XYDataModel?
    
    required init() {}
}

class XYDataModel: HandyJSON {
    var has_more: Int = 0
    var max_page: Int = 0
    var page: Int = 0
    var perpage: Int = 0
    var total: Int = 0
    var data: [XYDataDataModel]?
    
    required init() {}
}

class XYDataDataModel: HandyJSON {
    var created_at: String = ""
    var ended_at: String = ""
    var name: String = ""
    var days: String = ""
    var reason: String = ""
    var title: String = ""
    
    
    required init() {}
}

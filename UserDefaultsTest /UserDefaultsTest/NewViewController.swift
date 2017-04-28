//
//  NewViewController.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/27.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit
import HandyJSON
import SnapKit
class NewViewController: UIViewController {
    fileprivate var v: UITextView?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.subviews.first?.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.white
        
        let jsonString = "{\"id\":12345,\"color\":\"black\",\"name\":\"cat\"}"
        if let catModel = Cat.deserialize(from: jsonString) {
            print(catModel.color)
        }
        
        let cat = Animall(name: "cat", height: 30)
        
        let str = cat.toJSONString(prettyPrint: true)!
        print(str)
        
        let v = UITextView()
        v.backgroundColor = UIColor.red
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(44)
        }
        self.v = v
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notify: Notification) {
        
        if let rect = notify.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: 0.25) {
                var frame = self.v?.frame
                frame?.origin.y = rect.origin.y - 44
                self.v?.frame = frame!
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notify: NSNotification) {
        if let _ = notify.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: 0.25) {
                self.v?.transform = CGAffineTransform.identity
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        navigationController?.pushViewController(NewViewController(), animated: true)
    }
    
}

class Animal: HandyJSON {
    var id: Int = 0
    var color: String = ""
    
    required init() {}
}


class Cat: Animal {
    var name: String = ""
    
    required init() {}
}

class Animall: HandyJSON {
    
    var name: String?
    var height: Int?
    
    init(name: String, height: Int) {
        self.name = name
        self.height = height
    }
    
    required init() { }

}


//
//  ViewController.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/24.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
private let XYTableViewCellID = "XYTableViewCell"
private let kTableViewTopInset: CGFloat = 260
//MARK: - class
class ViewController: UIViewController {
    var bgImageV: UIView?
    var model: XYModel?
    var _lastOffsetY: CGFloat = 0
    //MARK: --- tableview
    private lazy var tableView: UITableView = {
        let tabV: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.XYScreenWidth, height: UIScreen.XYScreenHeight), style: .grouped)
        //注册cell
        tabV.register(XYTableViewCell.self, forCellReuseIdentifier: XYTableViewCellID)
        //代理／数据源
        tabV.delegate = self
        tabV.dataSource = self
        
        tabV.backgroundColor = UIColor.clear
        tabV.estimatedRowHeight = 70
        tabV.rowHeight = UITableViewAutomaticDimension
        
        tabV.contentInset = UIEdgeInsets(top: kTableViewTopInset + 64, left: 0, bottom: 0, right: 0)
        
        return tabV
    }()
    //MARK: --- headImageV
    fileprivate lazy var _headImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect(x: 0, y: 0, width: UIScreen.XYScreenWidth, height: Double(kTableViewTopInset))
        imageV.image = UIImage(named: "IMG_0890.JPG")
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.delegate = self
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        tableView.delegate = nil
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        //导航栏设置
        navigationBarSetting()
        //添加headImageV
        view.addSubview(_headImageV)
        //添加表
        view.addSubview(tableView)
        
        
        requestData()
    }
    //MARK: --- 导航栏设置
    private func navigationBarSetting() {
        //设置导航栏的颜色
        navigationController?.navigationBar.barTintColor = UIColor.red
        //设置导航栏title字体颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        //设置title
        navigationItem.title = "十里春风"
        //设置导航栏当前控制器的下一个控制器的返回按钮只有箭头，没有文字
        let barItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = barItem
        
        //设置导航栏子控件
        let barRightItem = UIBarButtonItem(title: "哈哈", style: .plain, target: nil, action: nil)
        //设置子控件的颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = barRightItem
        
        //在导航栏完全透明时，去除掉导航栏底部的黑线
//        navigationController?.navigationBar.clipsToBounds = true
        
        //肉眼看到的导航栏其实是一个UIImageView
        bgImageV = navigationController?.navigationBar.subviews.first
//        bgImageV?.alpha = 0.5
    }
    
    //MARK: --- 请求数据
    private func requestData() {
        let url = URL(string: "http://cloudhr.lab/kaoqin/api/myVacate?hr_token=a0169Bv4zSqCwZfotjH4J99ktLnzIgu5SkLqJEtgDhlGcEbpN6P/bNKrFmt9TfwBRg&page=1&status=2&tid=10000$vacate_type=0")
        //Alamofire 的使用
        Alamofire.request(url!,method: .get).responseJSON { (response) in
            //HandyJSON 的使用
            self.model = XYModel.deserialize(from: response.result.value as? NSDictionary)
            self.tableView.reloadData()
        }
    }
    
    //MARK: --- 通过上下文 制作图片
    fileprivate func imageWithBgColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(color.cgColor)
        currentContext?.addRect(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource 代理方法／数据源
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.data?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XYTableViewCellID, for: indexPath) as! XYTableViewCell
        
        if let model =  model?.data?.data?[indexPath.section] {
            cell.model = model
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = NewViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        var h = 64 - contentOffsetY
        if h < 64 {
            h = 64
        }
        _headImageV.frame.size.height = h
        
        var alpha: CGFloat = 0
        if contentOffsetY <= 0 {
            //324是tableview一开始的绝对值偏移量
            alpha = -contentOffsetY / 324
            
            alpha = alpha >= 1 ? 1 : alpha
            
            if navigationController?.navigationBar.tintColor != UIColor.white {
                navigationController?.navigationBar.tintColor = UIColor.white
                navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
            }

        } else {
            alpha = 0
            //当导航栏完全透明时，改变导航栏字体的颜色
            if navigationController?.navigationBar.tintColor != UIColor.black {
                navigationController?.navigationBar.tintColor = UIColor.black
                navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
            }

        }
        print(alpha)
        bgImageV?.alpha = alpha;
    }
}

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
//MARK: - class
class ViewController: UIViewController {
    var model: XYModel?
    //MARK: --- tableview
    private lazy var tableView: UITableView = {
        let tabV: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.XYScreenWidth, height: UIScreen.XYScreenHeight), style: .grouped)
        //注册cell
        tabV.register(XYTableViewCell.self, forCellReuseIdentifier: XYTableViewCellID)
        //代理／数据源
        tabV.delegate = self
        tabV.dataSource = self
        
        tabV.backgroundColor = UIColor.lightGray
        tabV.estimatedRowHeight = 70
        tabV.rowHeight = UITableViewAutomaticDimension
        
        return tabV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加表
        view.addSubview(tableView)
        
        requestData()
    }
    
    //MARK: --- 请求数据
    private func requestData() {
        let url = URL(string: "http://cloudhr.lab/kaoqin/api/myVacate?hr_token=f838qeyodpFcUjdRrBlPkvkNPMpEY3VXFK+nYE1DLiL2r3Yy6DPMLwmgsFbI0S6wnw&page=1&status=2&tid=10000$vacate_type=0")
        //Alamofire 的使用
        Alamofire.request(url!,method: .get).responseJSON { (response) in
            //HandyJSON 的使用
            if let model = XYModel.deserialize(from: response.result.value as? NSDictionary) {
                self.model = model
                self.tableView.reloadData()
            }
        }
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
        
        guard let model =  model?.data?.data?[indexPath.section] else { return cell }
        cell.model = model
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
}

//
//  XYTableViewCell.swift
//  UserDefaultsTest
//
//  Created by Xue Yang on 2017/4/27.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

import UIKit
import SnapKit
class XYTableViewCell: UITableViewCell {
    //数据模型
    var model: XYDataDataModel! {
        willSet (m){
            nameLab.text = m.name
            titleLab.text = m.title
            timelabTop.text = m.created_at
            timelabBottom.text = m.ended_at
            countLab.text = "请假\(m.days)天"
            reasonLab.text = "事由：\(m.reason)"
        }
    }
    /**
     *姓名背景view
     */
    private var nameBgView: UIView!
    //姓名lab
    private var nameLab: UILabel!
    //titleLab
    private var titleLab: UILabel!
    //时间lab 上
    private var timelabTop: UILabel!
    //时间lab 下
    private var timelabBottom: UILabel!
    //请假天数
    private var countLab: UILabel!
    //事由lab
    private var reasonLab: UILabel!
    
    private var tipsImgV: UIImageView!
    
    //MARK: --- 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- 获取一个UILabel对象
    private func createLabel(_ textColor: UIColor?, fontSize: CGFloat?, numberOfLines: Int?) -> UILabel{
        let lab = UILabel()
        lab.text = "测试"
        lab.textColor = textColor ?? UIColor.black
        lab.font = UIFont.systemFont(ofSize: fontSize ?? 16)
        lab.numberOfLines = numberOfLines ?? 1
        return lab
    }
    
    //MARK: --- 设置cell的UI
    private func setupUI() {
        //nameBgView
        nameBgView = UIView()
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        nameBgView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        nameBgView.layer.masksToBounds = true
        nameBgView.layer.cornerRadius = 22
        contentView.addSubview(nameBgView)
        nameBgView.snp.makeConstraints({ (make) in
            make.top.left.equalTo(8)
            make.width.height.equalTo(44)
        })
        
        //nameLab
        nameLab = createLabel(UIColor.white, fontSize: nil, numberOfLines: nil)
        nameLab.textAlignment = .center
        nameBgView.addSubview(nameLab)
        nameLab.snp.makeConstraints({ (make) in
            make.edges.equalTo(nameBgView)
        })
        
        tipsImgV = UIImageView()
        tipsImgV.image = UIImage(named: "check_reject")
        contentView.addSubview(tipsImgV)
        tipsImgV.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        //titleLab
        titleLab = createLabel(nil, fontSize: nil, numberOfLines: nil)
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints({ (make) in
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.top.equalTo(nameLab.snp.top).offset(5)
        })
        
        //timelabTop
        timelabTop = createLabel(nil, fontSize: nil, numberOfLines: nil)
        timelabTop.text = "2017-03-25 09:36"
        contentView.addSubview(timelabTop)
        timelabTop.snp.makeConstraints({ (make) in
            make.leading.equalTo(titleLab.snp.leading)
            make.top.equalTo(nameLab.snp.bottom)
            make.right.equalTo(0)
        })
        
        //timelabTop
        timelabBottom = createLabel(nil, fontSize: nil, numberOfLines: nil)
        timelabBottom.text = "2017-03-25 09:36"
        contentView.addSubview(timelabBottom)
        timelabBottom.snp.makeConstraints({ (make) in
            make.leading.equalTo(titleLab.snp.leading)
            make.top.equalTo(timelabTop.snp.bottom).offset(5)
            make.right.equalTo(0)
        })
        
        //countLab
        countLab = createLabel(nil, fontSize: nil, numberOfLines: nil)
        countLab.text = "请假1天"
        contentView.addSubview(countLab)
        countLab.snp.makeConstraints({ (make) in
            make.leading.equalTo(titleLab.snp.leading)
            make.top.equalTo(timelabBottom.snp.bottom).offset(5)
            make.right.equalTo(0)
        })
        
        //reasonLab
        reasonLab = createLabel(nil, fontSize: nil, numberOfLines: 0)
        reasonLab.text = "请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天请假1天"
        contentView.addSubview(reasonLab)
        reasonLab.snp.makeConstraints({ (make) in
            make.leading.equalTo(titleLab.snp.leading)
            make.top.equalTo(countLab.snp.bottom).offset(5)
            make.right.equalTo(-10)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
        })
    }
}

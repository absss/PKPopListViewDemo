//
//  PKPopListView.swift
//  Poker
//
//  Created by hehaichi on 2018/3/28.
//  Copyright © 2018年 YingQian. All rights reserved.
//

import UIKit
protocol PKPopListViewDelegate:class {
    func pkPopListView(withView listView:PKPopListView, didselected tag:Int)
    func pkPopListView(withView listView:PKPopListView, cellForItem item:UITableViewCell?,withTag tag:Int)
   
}
class PKPopListView: UIView {
    ///数据源
    var itemArray:[String] = []
    
    ///显示隐藏
    var showStatus:Bool = false {
        willSet{
            if newValue {
                self.alpha = 1.0
            }else{
                self.alpha = 0.0
            }
        }
    }
    
    /// 锚点
    var anchorPoint:CGPoint = CGPoint.init(x: 0, y: 0){
        willSet {
            self.layer.anchorPoint = newValue
        }
    }
    
    ///显示还是隐藏
    weak var delegate : PKPopListViewDelegate?
    
    ///是否需要能滚动
    var canScroll = false {
        willSet {
            self.tableView.isScrollEnabled = newValue
        }
    }
    private var cellClassName = "UITableViewCell"
    
    ///行高
    var itemHieght:CGFloat = 40.0
    
    let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    ///即使你此时还不能确定itemTitles和CGRect也使用此初始化方法
    init(itemTitle:[String],frame:CGRect) {
       super.init(frame: frame)
        self.itemArray = itemTitle
        self.addSubview(tableView)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = 0.001
        self.tableView.sectionFooterHeight = 0.001
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.isScrollEnabled = canScroll
    
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.8
        
        self.layer.anchorPoint = self.anchorPoint
       
        self.reloadData()
        self.showStatus = false
        
    }
    ///自定义tableViewCell
    public func registerTableViewCell(className:String){
        if className.count <= 0 {
            return
        }
        if let cl = NSClassFromString(className){
            self.tableView.register(cl, forCellReuseIdentifier: cellClassName)
        }
    }
    ///刷新数据和rect
    public func reloadData(){
        var size = self.frame.size
        let h = CGFloat.init(self.itemHieght * CGFloat.init(self.itemArray.count))
        size.height = h
        self.frame.size = size
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.tableView.reloadData()
    }
    
    ///弹出动画
    public func showWithAnimation(animation:Bool){
        self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        if  animation {
            UIView.animate(withDuration:0.2, animations: {
                self.showStatus = true
                self.transform = CGAffineTransform.identity
            })
        }else{
            self.showStatus = true
            self.transform = CGAffineTransform.identity
        }
    }
    ///隐藏动画
    public func hidenWithAnimation(animation:Bool){
        
        self.transform = CGAffineTransform.identity
        if animation {
            UIView.animate(withDuration:0.2, animations: {
                self.showStatus = false
                self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            })
        }else{
            self.showStatus = false
            self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }
    }
    
}
extension PKPopListView: UITableViewDelegate ,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return itemArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.itemHieght
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellClassName)
            cell?.textLabel?.font =  UIFont.systemFont(ofSize: 14)
            cell?.textLabel?.textColor =  UIColor.white
            cell?.textLabel?.text = self.itemArray[indexPath.row]
            cell?.textLabel?.textAlignment = .center
           
            cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell?.backgroundColor = UIColor.black
            cell?.selectionStyle = .none
            if let dele = self.delegate {
                dele.pkPopListView(withView: self, cellForItem: cell, withTag: indexPath.row)
            }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dele = self.delegate {
            dele.pkPopListView(withView: self, didselected: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
}


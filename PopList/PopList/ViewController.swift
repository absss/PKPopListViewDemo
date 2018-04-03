//
//  ViewController.swift
//  PopList
//
//  Created by hehaichi on 2018/4/3.
//  Copyright © 2018年 hehaichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     let popView = PKPopListView.init(itemTitle: ["1","2","3","4","5","6"], frame: CGRect.init(x: 80, y: 66, width: 90, height: 160 ))
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.popView)
        self.popView.showStatus = true
        self.popView.anchorPoint = CGPoint.init(x: 1, y: 0)//设置锚点，不清楚的可以去查下锚点的作用
        self.popView.canScroll = true
        self.popView.delegate = self
//        self.popView.registerTableViewCell(className: "YourTableViewCellName")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.popView.showStatus {
            self.popView.hidenWithAnimation(animation: false)
        }else{
            self.popView.showWithAnimation(animation: true)
        }
    }

}
extension ViewController: PKPopListViewDelegate{
    
    func pkPopListView(withView listView: PKPopListView, cellForItem item: UITableViewCell?, withTag tag: Int) {
        if let cell = item {
            cell.backgroundColor = UIColor.red
            
        }
    }
    
    func pkPopListView(withView listView: PKPopListView, didselected tag: Int) {
        
    }
}


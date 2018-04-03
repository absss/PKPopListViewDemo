# PKPopListViewDemo
弹出框

##使用方式
###初始化

``
let popView = PKPopListView.init(itemTitle: ["1","2","3","4","5","6"], frame: CGRect.init(x: 80, y: 66, width: 90, height: 160 ))``


###设置属性

``self.view.addSubview(self.popView)
        self.popView.showStatus = true
        self.popView.anchorPoint = CGPoint.init(x: 1, y: 0)//设置锚点，不清楚的可以去查下锚点的作用
        self.popView.canScroll = true
        self.popView.delegate = self
//        self.popView.registerTableViewCell(className: "YourTableViewCellName")
``


###实现协议方法


``
extension ViewController: PKPopListViewDelegate{
    
    func pkPopListView(withView listView: PKPopListView, cellForItem item: UITableViewCell?, withTag tag: Int) {
        if let cell = item {
            cell.backgroundColor = UIColor.red
            
        }
    }
    
    func pkPopListView(withView listView: PKPopListView, didselected tag: Int) {
        
    }
}
``

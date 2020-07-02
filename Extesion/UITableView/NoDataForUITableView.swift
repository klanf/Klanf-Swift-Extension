//
//  NoData+UITableView.swift
//
//  Created by ios on 2020/6/10.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//

extension UITableView {
    
    /// 类方法实现runtime的方法交换,处理tableview没有数据时的背景图
    public class func initializeMethod() {
        
        let originalSelector = #selector(UITableView.reloadData)
        let swizzledSelector = #selector(jc_reloadData)
        
        //  runtime获取函数方法
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
        
    }
    
    @objc func jc_reloadData(){
        self.jc_reloadData()
        
        let number = self.numberOfSections
        var havingData = false
        
        for i in 0..<number {
            if self.numberOfRows(inSection: i) > 0{
                havingData = true
                break
            }
        }
        
        if havingData {
            self.backgroundView = UIImageView()
        }else{
            let label = UILabel.init()
            label.text = NSLocalizedString("暂无更多数据", comment: "")
            label.textAlignment = .center
            self.backgroundView = label
            self.backgroundView?.contentMode = .center
        }
    }
}

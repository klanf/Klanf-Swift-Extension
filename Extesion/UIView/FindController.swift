//
//  FindViewController+UIView.swift
//
//  Created by klanf on 2020/5/14.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//

//MARK:- 获取当前视图控制器
public extension UIView {
    
    func findController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    
    func findNavigator() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        return nil
    }
}

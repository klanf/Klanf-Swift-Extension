//
//  Creat+UIAlertController.swift
//
//  Created by klanf on 2020/5/12.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    static func title(title:String?,message:String?, style:UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        return alert
    }

    func action(title:String,handle:((_ action:UIAlertAction)->Void)?, style:UIAlertAction.Style = .default) -> Self  {
        let action = UIAlertAction(title: title, style: style, handler: handle)
        self.addAction(action)
        return self
    }
    
    func showAlert(viewController:UIViewController,animation:Bool = true)  {
        viewController.present(self, animated: animation, completion: nil)
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}

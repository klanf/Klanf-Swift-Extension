//
//  File.swift
//
//  Created by klanf on 2020/5/28.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//

//  给 UIImageView 设置 TinColor
extension UIImageView {
    
    func setImageRenderingMode(mode : UIImage.RenderingMode) {
        image = image?.withRenderingMode(mode)
    }
}

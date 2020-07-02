//
//  File.swift
//
//
//  Created by klanf on 2020/6/26.
//  Copyright © 2020 com.klanf.ios. All rights reserved.
//

import Foundation

//  前缀
struct KPrefix<ProxyType> {
    var proxy: ProxyType
}

protocol KPrefixProtocol : Any {}
extension KPrefixProtocol {
    var zh: KPrefix<Self> {
        get { KPrefix(proxy: self) }
        set {}
    }
    static var zh: KPrefix<Self>.Type {
        get { KPrefix<Self>.self }
        set {}
    }
}

extension String: KPrefixProtocol {}
extension KPrefix where ProxyType == String {
    
    func localized() -> String {
        NSLocalizedString(proxy.self, comment: "")
    }
}

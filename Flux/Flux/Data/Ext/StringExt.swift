//
//  StringExt.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

extension String {
    static func randomAlphanumeric(_ length:Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        let lastIndex = base.count - 1
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0...lastIndex)
            randomString += base[
                base.index(base.startIndex, offsetBy: randomIndex - 1)..<base.index(base.startIndex, offsetBy: randomIndex)
            ]
            
        }
        return randomString
    }
}

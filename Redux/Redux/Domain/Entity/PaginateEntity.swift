//
//  PaginateEntity.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

struct PaginateEntity {
    var first:Int?
    var after:Int?
    
    var last:Int?
    var before:Int?
}
extension PaginateEntity : Codable {}


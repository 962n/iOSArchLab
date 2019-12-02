//
//  PageListEntity.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

struct PageListEntity<T:Codable> {
    var list:[T]
    var paginate:PaginateEntity
}

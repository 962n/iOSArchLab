//
//  UserSummaryEntity.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

struct UserSummaryEntity {
    var id:Int
    var name:String?
    var url:String?
    var isFollowing:Bool
}
extension UserSummaryEntity {
    static func createDummy(_ index:Int) -> UserSummaryEntity {
        return UserSummaryEntity(
            id: index,
            name: String.randomAlphanumeric(10),
            url: "",
            isFollowing: false
        )
    }
}

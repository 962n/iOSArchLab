//
//  Action.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

enum Action {
    case userList(_ list:[UserSummaryEntity],_ isRefresh:Bool)
    case paginateUserList(_ paginate:PaginateEntity)
    case isFetchingUserList(_ isFetching:Bool)
    case isRefreshingUserList(_ isRefreshing:Bool)
    case failFetchingUserList(_ error:Error)

    case selectedUser(_ user:UserSummaryEntity)
}

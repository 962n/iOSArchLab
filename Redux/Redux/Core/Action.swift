//
//  Action.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/06.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

extension UsersState {
    enum Action : ReSwift.Action {
        case loading(_ isRefresh:Bool)
        case refresh(list:[UserSummaryEntity],paginate:PaginateEntity)
        case loadMore(list:[UserSummaryEntity],paginate:PaginateEntity)
        case refreshFail(error:Error)
        case loadMoreFail(error:Error)
    }
}
struct RepositoryAction : ReSwift.Action  {
    var action:(@escaping(ReSwift.Action)->()) -> ()
}

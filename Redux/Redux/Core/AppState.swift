//
//  AppState.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/06.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

typealias ReduxStore = Store<AppState>

struct AppState : ReSwift.StateType {
    var usersState:UsersState = .init()
}
struct UsersState : ReSwift.StateType  {
    struct DataState : ReSwift.StateType {
        var list:[UserSummaryEntity] = []
        var isFetching = false
        var paginate:PaginateEntity?
        var hasNext:Bool {
            get {
                return paginate?.after != nil && !isFetching
            }
        }
    }
    enum CommandState : ReSwift.StateType {
        case nothing
        case refresh
        case loadMore
        case refreshFailure(_ error:Error)
        case loadMoreFailure(_ error:Error)
    }
    var dataState: DataState = .init()
    var commandState:CommandState = .nothing
}

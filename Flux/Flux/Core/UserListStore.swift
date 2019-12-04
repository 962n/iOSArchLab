//
//  UserListStore.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

enum UserListStoreEvent : StoreEvent {
    case users
    case isRefreshing
    case fetchError
    case other
}

class UserListStore: Store<UserListStoreEvent> {

    static let shared = UserListStore(dispatcher: .shared)
    
    private(set) var list:[UserSummaryEntity] = []
    private(set) var isRefreshing = false
    private(set) var isFetching = false
    private(set) var paginate:PaginateEntity?
    private(set) var error:Error?
    
    var hasNext:Bool {
        get {
            return paginate?.after != nil && !isFetching
        }
    }

    override func onDispatch(_ action: Action) {
        var event:UserListStoreEvent? = .other
        switch action {
        case .userList(let list, let isRefresh):
            if isRefresh {
                self.list.removeAll()
            }
            self.list.append(contentsOf: list)
            event = .users
        case .isFetchingUserList(let isFetching):
            self.isFetching = isFetching
        case .isRefreshingUserList(let isRefreshing):
            self.isRefreshing = isRefreshing
            event = .isRefreshing
        case .paginateUserList(let paginate):
            self.paginate = paginate
        case .failFetchingUserList(let error):
            self.error = error
        default:
            event = nil
        }
        if let event = event {
            onEmitted(event: event)
        }
    }

}

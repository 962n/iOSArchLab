//
//  UserListActionCreator.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

class UserListActionCreator {

    private let dispatcher:Dispatcher
    private let repository:UserListRepository
    private let limit = 20

    init(dispatcher:Dispatcher = .shared ,repository:UserListRepository) {
        self.dispatcher = dispatcher
        self.repository = repository
    }
    
    func fetchUserList(first:Int?,after:Int?) {
        let isRefreshing = first == nil && after == nil
        if isRefreshing {
            dispatcher.dispatch(.isRefreshingUserList(true))
        }
        dispatcher.dispatch(.isFetchingUserList(true))

        repository.fetch(
            first: first,
            after: after,
            limit: limit
        ) { [dispatcher] result in
            switch result {
            case .success((let users , let paginate)):
                dispatcher.dispatch(.userList(users,isRefreshing))
                dispatcher.dispatch(.paginateUserList(paginate))
            case .failure(let error):
                dispatcher.dispatch(.failFetchingUserList(error))
                break
            }
            if isRefreshing {
                dispatcher.dispatch(.isRefreshingUserList(false))
            }
            dispatcher.dispatch(.isFetchingUserList(false))
        }
    }

}

//
//  UserListActionCreator.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

class UserListActionCreator {

    private let store:ReduxStore
    private let repository:UserListRepository
    private let limit = 20

    init(store:ReduxStore ,repository:UserListRepository) {
        self.store = store
        self.repository = repository
    }
    
    func fetchUserList(first:Int?,after:Int?) {
        let isRefreshing = first == nil && after == nil
        store.dispatch(UsersState.Action.loading(isRefreshing))
        
        let action = RepositoryAction(action: { [weak self] callback in
            guard let self = self else {
                // エラーを返す
                return
            }
            self.repository.fetch(
                first: first,
                after: after,
                limit: self.limit
            ) { result in
                switch result {
                case .success((let users , let paginate)):
                    let action = isRefreshing ? UsersState.Action.refresh(list: users, paginate: paginate)
                        : UsersState.Action.loadMore(list: users, paginate: paginate)
                    callback(action)
                case .failure(let error):
                    let action = isRefreshing ? UsersState.Action.refreshFail(error: error)
                        : UsersState.Action.loadMoreFail(error: error)
                    callback(action)
                }
            }
        })
        store.dispatch(action)
    }

}

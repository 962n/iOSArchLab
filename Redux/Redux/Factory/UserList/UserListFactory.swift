//
//  UserListFactory.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

struct UserListFactory {
    private let store:ReduxStore
    
    init(store:ReduxStore) {
        self.store = store
    }
    func create() -> UIViewController {
        let actionCreator = UserListActionCreator(
            store: store,
            repository: DummyUserListRepositoryImpl()
        )
        return UserListController(actionCreator: actionCreator, store: store)
    }
}


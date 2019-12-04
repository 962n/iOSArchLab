//
//  UserListFactory.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

struct UserListFactory : ViewControllerFactory {

    func create() -> UIViewController {
        let actionCreator = UserListActionCreator(
            dispatcher: .shared,
            repository: DummyUserListRepositoryImpl()
        )
        return UserListController(actionCreator: actionCreator, store: .shared)
    }
}

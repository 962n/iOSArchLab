//
//  Middlewares.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

let repositoryMiddleware: ReSwift.Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            if let repositoryAction = action as? RepositoryAction {
                repositoryAction.action { convertAction in
                    next(convertAction)
                }
            } else {
                return next(action)
            }
        }
    }
}

//
//  Reducer.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

func appReducer(action: ReSwift.Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    let reducers = [
        usersDataStateReducer,
        usersCommandStateReducer
    ]
    reducers.forEach { reducer in
        state = reducer(action,state)
    }
    return state
}
func usersDataStateReducer(action: ReSwift.Action, state: AppState) -> AppState {
    var state = state
    switch action {
    case UsersState.Action.refresh(let list,let paginate):
        state.usersState.dataState = UsersState.DataState(
            list: list,
            isFetching: false,
            paginate: paginate
        )
    case UsersState.Action.loadMore(let list,let paginate):
        state.usersState.dataState.list.append(contentsOf: list)
        state.usersState.dataState = UsersState.DataState(
            list: state.usersState.dataState.list,
            isFetching: false,
            paginate: paginate
        )
    case UsersState.Action.loadMoreFail:
        state.usersState.dataState = UsersState.DataState(
            list: state.usersState.dataState.list,
            isFetching: false,
            paginate: state.usersState.dataState.paginate
        )
    case UsersState.Action.refreshFail:
        state.usersState.dataState = UsersState.DataState(
            list: state.usersState.dataState.list,
            isFetching: false,
            paginate: state.usersState.dataState.paginate
        )
    case UsersState.Action.loading:
        state.usersState.dataState.isFetching = true
    default:
        break
    }
    return state
}
func usersCommandStateReducer(action: ReSwift.Action, state: AppState) -> AppState {
    var state = state
    switch action {
    case UsersState.Action.refresh:
        state.usersState.commandState = .refresh
    case UsersState.Action.loadMoreFail(let error):
        state.usersState.commandState = .refreshFailure(error)
    case UsersState.Action.refreshFail(let error):
        state.usersState.commandState = .loadMoreFailure(error)
    default:
        break
    }
    return state
}


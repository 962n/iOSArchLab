//
//  UserListController.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

class UserListController: UITableViewController {

    private var dataSource = UserListDataSource()
    private var actionCreator:UserListActionCreator

    private let commandSubscriber:StoreSubscriberWrap<UsersState.CommandState>
    private lazy var commandSubscriberToken:SubscriberToken = {
        return self.commandSubscriber.subscribe { [weak self] newState in
            self?.handleCommandState(newState)
        }
    }()
    
    private let dataSubscriber:StoreSubscriberWrap<UsersState.DataState>
    private lazy var dataSubscriberToken:SubscriberToken = {
        return self.dataSubscriber.subscribe { [weak self] newState in
            self?.handleDataState(newState)
        }
    }()
    
    private var store:ReSwift.Store<AppState>
    
    private var dataState : UsersState.DataState {
        get {
            return store.state.usersState.dataState
        }
    }
    private var commandState : UsersState.CommandState {
        get {
            return store.state.usersState.commandState
        }
    }

    init(
        actionCreator:UserListActionCreator,
        store:ReSwift.Store<AppState>
    ) {
        self.actionCreator = actionCreator
        self.store = store
        dataSubscriber = StoreSubscriberWrap(store: store)
        commandSubscriber = StoreSubscriberWrap(store: store)
        super.init(nibName: nil, bundle: nil)
        let _ = dataSubscriberToken
        let _ = commandSubscriberToken
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        dataSubscriber.unsbscribe(dataSubscriberToken)
        commandSubscriber.unsbscribe(commandSubscriberToken)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        if dataState.list.isEmpty {
            refresh(sender: refreshControl!)
        } else {
            handleDataState(dataState)
        }
    }

    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        dataSource.configure(tableView)
        dataSource.didCommand = { [didCommand] command in
            didCommand(command)
        }
        dataSubscriber.configure {
            appState in
            return appState.usersState.dataState
        }
        commandSubscriber.configure {
            appState in
            return appState.usersState.commandState
        }
    }

    @objc
    func refresh(sender: UIRefreshControl) {
        actionCreator.fetchUserList(first: nil, after: nil)
    }
    
}
extension UserListController {
    private func didCommand(_ command:UserListDataSource.Command) {
        switch command {
        case .cell(let user):
            break
        case .paginate:
            if dataState.hasNext {
                actionCreator.fetchUserList(first: nil, after: dataState.paginate?.after)
            }
        }
    }
}
extension UserListController {

    private func handleCommandState(_ state:UsersState.CommandState) {
        switch state {
        case .nothing:
            break
        case .refresh:
            break
        case .refreshFailure( _):
            break
        case .loadMore:
            break
        case .loadMoreFailure( _):
            break
        }
    }
    
    private func handleDataState(_ state:UsersState.DataState) {
        dataSource.refresh(list: state.list)
        tableView.reloadData()
    }

}


//
//  UserListController.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

class UserListController: UITableViewController {

    private var dataSource = UserListDataSource()
    private var actionCreator:UserListActionCreator
    private var store:UserListStore
    lazy var subscription = {
        return store.addListener(callback: { [weak self] event in
            self?.handleEvent(event)
        })
    }()
    
    init(
        actionCreator:UserListActionCreator,
        store:UserListStore
    ) {
        self.actionCreator = actionCreator
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        store.removeListener(subscription: subscription)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        if store.list.isEmpty {
            refresh(sender: refreshControl!)
        } else {
            handleEvent(.users)
        }
    }

    private func configure() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)

//        tableView.addSubview(refreshControl ?? UIRefreshControl())
        
        dataSource.configure(tableView)
        dataSource.didCommand = { [didCommand] command in
            didCommand(command)
        }
        let _ = subscription
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
            if store.hasNext {
                actionCreator.fetchUserList(first: nil, after: store.paginate?.after)
            }
        }
    }

    private func handleEvent(_ event:UserListStoreEvent) {
        switch event {
        case .isRefreshing:
            if !store.isRefreshing {
                refreshControl?.endRefreshing()
            }
        case .users:
            dataSource.refresh(list: store.list)
            tableView.reloadData()
        case .fetchError:
            refreshControl?.endRefreshing()
        case .other:
            // do nothing
            break
        }
    }
}

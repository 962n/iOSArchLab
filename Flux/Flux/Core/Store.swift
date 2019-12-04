//
//  Store.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

typealias Subscription = NSObjectProtocol

protocol StoreEvent {}

class Store<Event:StoreEvent> {
    let storeChanged = Notification.Name("store-changed")

    private let notificationCenter:NotificationCenter

    private let dispatcher:Dispatcher
    private var listeners:[(Event)->()] = []

    private lazy var dispatchToken : DispatcherToken = {
        return self.dispatcher.register(callback: { [weak self] action in
            self?.onDispatch(action)
        })
    }()
    
    
    init(dispatcher:Dispatcher) {
        self.dispatcher = dispatcher
        notificationCenter = NotificationCenter()
        _ = dispatchToken
    }

    deinit {
        dispatcher.unregister(token: dispatchToken)
    }
    
    func onDispatch(_ action:Action) {
        fatalError("must override")
    }
    
    final func onEmitted(event:Event) {
        notificationCenter.post(name: storeChanged, object: nil, userInfo: ["event":event])
    }
    
    final func addListener(callback: @escaping (Event)->()) -> Subscription{
        let using : (Notification) -> () = {[weak self] notification in
            if notification.name != self?.storeChanged {
                return
            }
            guard
                let userInfo = notification.userInfo,
                let event = userInfo["event"] as? Event
            else {
                return
            }
            callback(event)
        }
        return notificationCenter.addObserver(
            forName: storeChanged,
            object: nil,
            queue: nil,
            using: using)
    }
    
    final func removeListener(subscription:Subscription) {
        notificationCenter.removeObserver(subscription)
    }

}

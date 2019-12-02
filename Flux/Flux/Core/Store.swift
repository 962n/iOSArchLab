//
//  Store.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

typealias Subscription = NSObjectProtocol

class Store {
    private struct NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }
    
    private let notificationCenter:NotificationCenter
    private let dispatcher:Dispatcher
    private lazy var dispatchToken : DispatcherToken = {
        return self.dispatcher.register(callback: { action in
            
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
    
    final func onEmitted() {
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }
    
    final func addListener(callback: @escaping ()->()) -> Subscription{
        let using : (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged {
                callback()
            }
        }
        return notificationCenter.addObserver(
            forName: NotificationName.storeChanged,
            object: nil,
            queue: nil,
            using: using)
    }
    
    final func removeListener(subscription:Subscription) {
        notificationCenter.removeObserver(subscription)
    }

}

//
//  StoreSubscriberWrap.swift
//  Redux
//
//  Created by takahiro.kurokawa on 2019/12/08.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit
import ReSwift

typealias SubscriberToken = String

class StoreSubscriberWrap<SubState/*:ReSwift.StateType*/> : NSObject {

    private let lock = NSRecursiveLock()
    private let store:ReduxStore
    private var callbacks:[String:(_ state:SubState) -> ()] = [:]
    
    init(store:ReduxStore) {
        self.store = store
    }
    func configure(_ selector:@escaping (AppState)-> SubState) {
        store.subscribe(self, transform: { subscriber in
            return subscriber.select { appState in
                return selector(appState)
            }
        })
    }
    deinit {
        store.unsubscribe(self)
    }
    
    func subscribe(_ newState : @escaping (SubState)->()) -> SubscriberToken {
        lock.lock()
        defer { lock.unlock() }
        let token = UUID().uuidString
        callbacks[token] = newState
        return token
    }

    func unsbscribe(_ token:SubscriberToken) {
        lock.lock()
        defer { lock.unlock() }
        callbacks.removeValue(forKey: token)
    }
}
extension StoreSubscriberWrap : StoreSubscriber{

    func newState(state: SubState) {
        lock.lock()
        defer { lock.unlock() }
        callbacks.forEach{_, callback in
            callback(state)
        }
    }
    
    typealias StoreSubscriberStateType = SubState
    
    
}

//
//  Dispatcher.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

typealias DispatcherToken = String

class Dispatcher {
    
    static let shared = Dispatcher()
    
    let lock = NSRecursiveLock()
    private var callbacks:[DispatcherToken:(Action)-> Void] = [:]
    
    func register(callback : @escaping (Action)-> Void ) -> DispatcherToken {
        lock.lock()
        defer { lock.unlock() }
        let token = UUID().uuidString
        callbacks[token] = callback
        return token
    }
    
    func unregister(token:DispatcherToken) {
        lock.lock()
        defer { lock.unlock() }

        callbacks.removeValue(forKey: token)
    }
    
    func dispatch(_ action : Action) {
        lock.lock()
        defer { lock.unlock() }
        
        callbacks.forEach{_, callback in
            callback(action)
            
        }
    }

}

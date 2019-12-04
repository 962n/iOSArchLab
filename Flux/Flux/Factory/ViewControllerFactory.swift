//
//  ViewControllerFactory.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

protocol ViewControllerFactory {
    associatedtype ViewController: UIViewController
    
    func create() -> ViewController
}

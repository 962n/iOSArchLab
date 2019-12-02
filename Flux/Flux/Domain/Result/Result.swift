//
//  Result.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}

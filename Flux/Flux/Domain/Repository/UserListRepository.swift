//
//  UserListRepository.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/02.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

protocol UserListRepository {

    func fetch(
        first:Int?,
        after:Int? ,
        limit:Int,
        _ result: @escaping (Result<([UserSummaryEntity],PaginateEntity)>)->()
    )

}

class DummyUserListRepositoryImpl : UserListRepository {

    func fetch(
        first:Int?,
        after:Int? ,
        limit:Int,
        _ result: @escaping (Result<([UserSummaryEntity],PaginateEntity)>)->()
    ) {
        if let _ = first , let _ = after {
            result(.failure(ServerFailure.parameter))
            return
        }
        let isReverse = first != nil
        var index = first ?? after ?? 0
        let updateIndex = { (_ index:Int) in
            return isReverse ? index-1 : index+1
        }
        var list:[UserSummaryEntity] = []
        for _ in 0..<limit {
            index = updateIndex(index)
            let entity = UserSummaryEntity.createDummy(index)
            list.append(entity)
        }
        let paginate = PaginateEntity(
            first: list.first?.id,
            after: list.last?.id,
            last: nil,
            before: nil
        )
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3,
            execute: {
                result(.success((list,paginate)))
            }
        )

    }

}

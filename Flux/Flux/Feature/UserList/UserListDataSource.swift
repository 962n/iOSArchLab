//
//  UserListDataSource.swift
//  Flux
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import UIKit

class UserListDataSource : NSObject {
    
    private var list:[UserSummaryEntity] = []
    var didCommand:((_ command:Command)->())?
    
    enum Command {
        case cell(_ user:UserSummaryEntity)
        case paginate
    }
    
    func configure(_ tableView:UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func refresh(list:[UserSummaryEntity]) {
        self.list = list
    }
}
extension UserListDataSource : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row].name
        return cell
    }
}
extension UserListDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didCommand?(.cell(list[indexPath.row]))
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height <= 0 {
            return
        }
        if (scrollView.contentSize.height - scrollView.bounds.size.height) <= scrollView.contentOffset.y {
            didCommand?(.paginate)
        }
    }
}


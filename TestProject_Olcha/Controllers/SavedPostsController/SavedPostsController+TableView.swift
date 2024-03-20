//
//  SavedPostsController+TableView.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 02/03/24.
//

import UIKit

//MARK: - UITableViewDataSource
extension SavedPostsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedPostsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostTVC.identifier, for: indexPath) as?  PostTVC else { return UITableViewCell() }
        
        postCell.setValues(savedPostsList[indexPath.row])
        postCell.cellType = .savePosts
        postCell.updateList = { cellType in
            switch cellType {
            case .allPosts: break
            case .savePosts: tableView.reloadData()
            }
        }
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension SavedPostsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = PostDetailController()
        detailVC.setValues(savedPostsList[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

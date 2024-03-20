//
//  PostsController+TableView.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

//MARK: - UITableViewDataSource
extension PostsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchingPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostTVC.identifier, for: indexPath) as?  PostTVC else { return UITableViewCell() }
        
        postCell.setValues(searchingPost[indexPath.row])
        postCell.cellType = .allPosts
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension PostsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = PostDetailController()
        detailVC.setValues(searchingPost[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

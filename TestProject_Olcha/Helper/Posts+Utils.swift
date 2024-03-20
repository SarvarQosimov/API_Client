//
//  Posts+Utils.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import Foundation

protocol PostDelegate: AnyObject {
    func updatePosts(_ posts: PostModelList)
    func setSearchedPosts(_ posts: PostModelList)
}

protocol SavedPostsDelegate: AnyObject {
    func updatePosts(_ posts: PostModelList)
    func reloadTableView()
}

enum PostCellType {
    case allPosts
    case savePosts
}

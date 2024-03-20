//
//  SavedPostsViewModel.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 02/03/24.
//

import Foundation

class SavedPostsViewModel {
    var postDelegate: SavedPostsDelegate
    
    init(postDelegate: SavedPostsDelegate!) {
        self.postDelegate = postDelegate
    }
    
    func fetchSavedPosts(){
        let list = DataBaseMananger.shared.fetchMyCustomModels()
        
        var savedPosts: [PostModelElement] = []
        
        list.forEach { post in
            savedPosts.append(
                PostModelElement(
                    userID: post.userId,
                    id: post.id,
                    title: post.postTitle ?? "",
                    body: post.postDescription ?? ""
                )
            )
        }
        
        postDelegate.updatePosts(savedPosts)
    }
}

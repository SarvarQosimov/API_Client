//
//  PostsViewModel.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

class PostsViewModel {
    weak var postDelegate: PostDelegate!
    var postList: PostModelList = []
    
    init(postDelegate: PostDelegate!) {
        self.postDelegate = postDelegate
    }
    
    func getPosts() {
        ApiClient.getPosts { [weak self] posts in
            guard let self = self else { return }
            guard let posts = posts else { return }
            
            postList = posts
            postDelegate.updatePosts(posts)
        }
    }
    
    func findPost(_ postTitle: String){
        if postTitle.isEmpty {
            postDelegate.setSearchedPosts(postList)
        } else {
            postDelegate.setSearchedPosts(postList.filter({
                $0.title.lowercased().contains(postTitle.lowercased())
            }))
        }
       
    }
    
}

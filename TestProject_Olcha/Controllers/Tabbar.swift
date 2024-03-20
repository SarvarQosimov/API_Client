//
//  Tabbar.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

class Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabbar()
    }
    
    private func initTabbar(){
        let postsNavCantroller = UINavigationController(rootViewController: PostsController())
        let postsTabbarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        postsNavCantroller.tabBarItem = postsTabbarItem
        
        let savedPostsNavCantroller = UINavigationController(rootViewController: SavedPostsController())
        let savedPostsTabbarItem = UITabBarItem(title: "", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        savedPostsNavCantroller.tabBarItem = savedPostsTabbarItem
        
        viewControllers = [postsNavCantroller, savedPostsNavCantroller]
    }
    

}

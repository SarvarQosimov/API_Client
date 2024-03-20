//
//  SavedPostsController.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 02/03/24.
//

import UIKit

class SavedPostsController: UIViewController {
    //MARK: - elements
    let tableView = UITableView()
    
    //MARK: - variables
    var savedPostsList: [PostModelElement] = []
    var savePostsViewModel: SavedPostsViewModel!
    
    //MARK: - view life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        savePostsViewModel = SavedPostsViewModel(postDelegate: self)
        getSavedPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if savePostsViewModel != nil {
            getSavedPosts()
        }
    }
    
    //MARK: - functions
    private func initViews(){
        title = "Saved posts"
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTVC.self, forCellReuseIdentifier: PostTVC.identifier)
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func getSavedPosts(){
        savePostsViewModel.fetchSavedPosts()
    }
    
}

extension SavedPostsController: SavedPostsDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func updatePosts(_ posts: PostModelList) {
        savedPostsList = posts
        tableView.reloadData()
    }
}

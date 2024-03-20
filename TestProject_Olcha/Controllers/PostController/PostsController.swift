//
//  PostsController.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

class PostsController: UIViewController {
    
    let tableView = UITableView()
    let searchVC = UISearchController()

    var postsList: PostModelList = []
    var searchingPost: PostModelList = []
    var postViewModel: PostsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        initViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchVC.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    
    //MARK: func
    
    private func setViewModel(){
        postViewModel = PostsViewModel(postDelegate: self)
        postViewModel.getPosts()
    }
    
    private func initViews(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Posts"
        
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPressed(_:)))
        
        navigationItem.rightBarButtonItem = rightItem

        searchVC.searchBar.delegate = self

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
    
    @objc func searchPressed(_ sender: Any){
        present(searchVC, animated: false)
    }

}

extension PostsController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchVC.searchBar.isHidden = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        postViewModel.findPost("")
        searchVC.searchBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        postViewModel.findPost(searchText)
    }
}

extension PostsController: PostDelegate {
    func updatePosts(_ posts: PostModelList) {
        self.postsList = posts
        searchingPost = posts
        tableView.reloadData()
    }
    
    func setSearchedPosts(_ posts: PostModelList) {
        searchingPost = posts
        tableView.reloadData()
    }
}

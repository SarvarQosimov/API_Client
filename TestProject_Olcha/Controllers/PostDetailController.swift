//
//  PostDetailController.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

class PostDetailController: UIViewController {
    
    let scrollView = UIScrollView()
    let postTitle = UILabel()
    let userView = UIView()
    let userImage = UIImageView()
    let userNameLabel = UILabel()
    let showUserLabel = UILabel()
    let postDescription = UILabel()
    
    var post: PostModelElement!
    var userInfo: UserModelList?
    
    //MARK: life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: functions
    
    func setValues(_ post: PostModelElement){
        self.post = post
        
        initViews()
        
        postTitle.text = post.title
        postDescription.text = post.body
    }
    
    func getUsers(){
        ApiClient.getUser(userID: Int(post.userID)) { [weak self] userModel in
            guard let self = self else { return }
            guard let userModel = userModel else { return }
            
            userInfo = userModel
            
            self.userNameLabel.text = userModel.first?.name
        }
    }
    
    private func initViews(){
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        postTitle.font = UIFont(name: Keys.FuturaBoldFont, size: 21)
        postTitle.numberOfLines = 0
        
        scrollView.addSubview(userView)
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.layer.cornerRadius = 9
        userView.clipsToBounds = true
        userView.backgroundColor = .systemGray5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(printUserInfo(_:)))
        userView.addGestureRecognizer(tapGesture)
        userView.isUserInteractionEnabled = true
        
        userView.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.image = UIImage(named: Keys.userImage)
        userImage.layer.cornerRadius = 15
        userImage.clipsToBounds = true
        
        userView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = .systemFont(ofSize: 13)
        userNameLabel.numberOfLines = 0
        
        userView.addSubview(showUserLabel)
        showUserLabel.translatesAutoresizingMaskIntoConstraints = false
        showUserLabel.font = .systemFont(ofSize: 9)
        showUserLabel.textColor = .systemGray
        showUserLabel.text = "Show user"
        
        scrollView.addSubview(postDescription)
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.font = UIFont(name: Keys.FuturaMediumFont, size: 17)
        postDescription.numberOfLines = 0
        
        initConstraints()
    }
    
    private func initConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            postTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            postTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            postTitle.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -5),
            
            userView.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 15),
            userView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            userView.heightAnchor.constraint(equalToConstant: 45),
            
            userImage.widthAnchor.constraint(equalToConstant: 30),
            userImage.heightAnchor.constraint(equalToConstant: 30),
            userImage.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 5),
            userImage.centerYAnchor.constraint(equalTo: userView.centerYAnchor),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 40),
            userNameLabel.topAnchor.constraint(equalTo: userImage.topAnchor),
            userNameLabel.rightAnchor.constraint(equalTo: userView.rightAnchor, constant: -5),
            
            showUserLabel.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 40),
            showUserLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            showUserLabel.rightAnchor.constraint(equalTo: userView.rightAnchor, constant: -5),
            
            postDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            postDescription.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 15),
            postDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            postDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -5)
        ])
    }
    
    @objc func printUserInfo(_ sender: UITapGestureRecognizer){
        if let userInfo = userInfo {
            print(userInfo)
        }
    }
    
}

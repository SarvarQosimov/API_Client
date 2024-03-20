//
//  PostTVC.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

class PostTVC: UITableViewCell {
    static let identifier = String(describing: PostTVC.self)
    
    let baseView = UIView()
    let isSavedButton = UIButton()
    let postTitle = UILabel()
    let chevronImage = UIImageView()
    
    var isSaved = false
    var post: PostModelElement!
    var cellType: PostCellType = .allPosts
    var updateList:( (PostCellType) -> Void )?
    
    func setValues(_ post: PostModelElement){
        initViews()
        self.post = post
        postTitle.text = post.title
        setChevronImageBySaving()
    }
    
    private func initViews(){
        contentView.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.layer.cornerRadius = 7
        baseView.clipsToBounds = true
        baseView.backgroundColor = .systemGray6
        
        baseView.addSubview(isSavedButton)
        isSavedButton.translatesAutoresizingMaskIntoConstraints = false
        isSavedButton.addTarget(self, action: #selector(savedPressed(_:)), for: .touchUpInside)
        
        baseView.addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        postTitle.textAlignment = .left
        postTitle.font = UIFont(name: "Futura Bold", size: 17)
        postTitle.numberOfLines = 0
        
        baseView.addSubview(chevronImage)
        chevronImage.translatesAutoresizingMaskIntoConstraints = false
        chevronImage.image = UIImage(systemName: "chevron.right")
        chevronImage.tintColor = .lightGray
        
        initConstraints()
    }
    
    private func initConstraints(){
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            baseView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            isSavedButton.widthAnchor.constraint(equalToConstant: 41),
            isSavedButton.heightAnchor.constraint(equalToConstant: 33),
            isSavedButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 0),
            isSavedButton.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            
            postTitle.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 40),
            postTitle.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5),
            postTitle.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -30),
            postTitle.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5),
            
            chevronImage.widthAnchor.constraint(equalToConstant: 11),
            chevronImage.heightAnchor.constraint(equalToConstant: 15),
            chevronImage.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -15),
            chevronImage.centerYAnchor.constraint(equalTo: baseView.centerYAnchor)
        ])
    }
    
    func setChevronImageBySaving(){
        let access = DataBaseMananger.shared.isSavedPost(post)
        isSaved = access
        isSavedButton.setImage(
            UIImage(systemName: access ? "bookmark.fill" : "bookmark"),
            for: .normal)
    }
    
    @objc func savedPressed(_ sender: UIButton){
        if isSaved {
            DataBaseMananger.shared.deleteMyCustomModel(post)
            isSavedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            DataBaseMananger.shared.savePost(post)
            isSavedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        
        isSaved.toggle()
        
        updateList?(cellType)
    }
    
}

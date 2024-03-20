//
//  DataBaseMananger.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 02/03/24.
//

import UIKit
import CoreData

class DataBaseMananger {

    static let shared = DataBaseMananger()
    var savedPosts = [Post]()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Keys.dataBaseName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func savePost(_ post: PostModelElement) {
        let savingPost = Post(context: viewContext)
        savingPost.id = post.id
        savingPost.userId = post.userID
        savingPost.postTitle = post.title
        savingPost.postDescription = post.body
        
       saveDB()
    }
    
    func deleteMyCustomModel(_ myCustomModel: PostModelElement) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let existingPosts = try viewContext.fetch(fetchRequest)
            existingPosts.forEach { post in
                if post.id == myCustomModel.id {
                    viewContext.delete(post)
                    saveDB()
                }
            }
        } catch {
            print("Failed to delete Post: \(error.localizedDescription)")
        }
    }
    
    func fetchMyCustomModels() -> [Post] {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let myCustomModels = try viewContext.fetch(fetchRequest)
            savedPosts = myCustomModels
            return myCustomModels
        } catch {
            print("Failed to fetch MyCustomModels: \(error.localizedDescription)")
            return []
        }
    }
    
    func isSavedPost(_ post: PostModelElement) -> Bool {
        let postList = fetchMyCustomModels()
        for postElement in postList {
            if postElement.id == post.id {
                return true
            }
        }
        
        return false
    }
    
    private func saveDB(){
        do {
            try viewContext.save()
        } catch {
            print("Failed  to save: \(error.localizedDescription)")
        }
    }
    
}



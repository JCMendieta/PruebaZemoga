//
//  FetchData.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//

import Foundation

protocol FetchManagerDelegate {
    func didUpdatePosts(with viewModel: PostsScreenViewModel)
    func didUpdateUsers()
    func didUpdateComments()
}

struct FetchManager {
    let postsStringURL="https://jsonplaceholder.typicode.com/posts"
    let usersStringURL="https://jsonplaceholder.typicode.com/users"
    let commentsStringURL="https://jsonplaceholder.typicode.com/posts/"
    
    var delegate: FetchManagerDelegate?
    
    enum FetchType {
        case posts, users, comments
    }
    
    func fetchPosts(){
        if let url = URL(string: postsStringURL) {
            performRequest(url: url, for: .posts)
        }
    }
    
    func fetchUsers(){
        if let url = URL(string: usersStringURL) {
            
        }
        
    }
    
    func fetchCommentsFor(idPost: Int){
        if let url = URL(string: "\(commentsStringURL)\(idPost)") {
            
        }
        
    }
    
    func performRequest(url: URL, for fetchType: FetchType){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                switch fetchType {
                case .posts:
                    parsePostsJSON(json: safeData)
                case .users:
                    print("")
                case .comments:
                    print("2")
                }
                
            }
        }
        task.resume()
    }
    
    func parsePostsJSON(json: Data) {
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Post].self, from: json){
            let postsScreenViewModel = Utils.getPostsViewModel(posts: decodedData)
            let viewModel = PostsScreenViewModel(posts: postsScreenViewModel, favoritePosts: [])
            delegate?.didUpdatePosts(with: viewModel)
        }
    }
}

                
                

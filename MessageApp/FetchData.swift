//
//  FetchData.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//

import Foundation

protocol FetchPostsManagerDelegate {
    func didUpdatePosts(with viewModel: PostsScreenViewModel)
    func didUpdateUsers(with users: [User])
}

protocol FetchPostDetailsManagerDelegate {
    func didUpdateComments(with comments: [Comment])
}

struct FetchPostsManager {
    let postsStringURL = URLs.posts
    let usersStringURL = URLs.users
    var delegate: FetchPostsManagerDelegate?
    
    func fetchPosts(){
        if let url = URL(string: postsStringURL) {
            performRequest(url: url, for: .posts)
        }
    }
    
    func fetchUsers(){
        if let url = URL(string: usersStringURL) {
            performRequest(url: url, for: .users)
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
                    parseUsersJSON(json: safeData)
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
    
    func parseUsersJSON(json: Data) {
        let decoder = JSONDecoder()
        if let users = try? decoder.decode([User].self, from: json){
            delegate?.didUpdateUsers(with: users)
        }
    }
}

struct FetchPostsDetailsManager {
    let commentsStringURL = URLs.commets
    var delegate: FetchPostDetailsManagerDelegate?
    
    func getCommentsForPostWith(id: Int){
        if let url = URL(string: "\(commentsStringURL)\(id)/comments") {
            performRequest(url: url)
        }
    }
    
    func performRequest(url: URL){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                parseCommentsJSON(json: safeData)
            }
        }
        task.resume()
    }
    
    func parseCommentsJSON(json: Data) {
        let decoder = JSONDecoder()
        if let comments = try? decoder.decode([Comment].self, from: json){
            delegate?.didUpdateComments(with: comments)
        }
    }
}

enum FetchType {
    case posts, users
}

struct URLs {
    static let posts = "https://jsonplaceholder.typicode.com/posts"
    static let users = "https://jsonplaceholder.typicode.com/users"
    static let commets = "https://jsonplaceholder.typicode.com/posts/"
}

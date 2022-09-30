//
//  Utils.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 30/09/22.
//

import Foundation

struct Utils {
    static func getPostsViewModel(posts: [Post]) -> [PostViewModel] {
        posts.map { post in
            return PostViewModel(
                userId: post.userId,
                postId: post.id,
                title: post.title,
                body: post.body,
                isFavorite: false
            )
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

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

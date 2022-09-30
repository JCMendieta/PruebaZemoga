//
//  PostsViewModel.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//

import Foundation

struct PostsScreenViewModel {
    var posts: [PostViewModel]
    var favoritePosts: [FavoritePostViewModel]
    //ELIMINAR?
//    var postsCount: Int {
//        return posts.count
//    }
//    var favoriteCount: Int {
//        return favoritePosts.count
//    }

    
    mutating func addToFavorite(post: PostViewModel, indexRow: Int) {
        if post.isFavorite == false {
            posts[indexRow].isFavorite = true
            let favoritePost = FavoritePostViewModel(post: post, id: indexRow)
            favoritePosts.append(favoritePost)
        }
    }
    
    mutating func removeFromFavorite(at index: Int) {
        let idOriginalPost = favoritePosts[index].id
        favoritePosts.remove(at: index)
        posts[idOriginalPost].isFavorite = false
    }
    
    mutating func removeNotFavoritePosts() {
        let onlyFavoritePosts = posts.filter { post in
            post.isFavorite
        }
        posts = onlyFavoritePosts
    }
    
    mutating func removePostWith(index: Int){
        let indexOfFavoritePost = favoritePosts.firstIndex { favoritePost in
            favoritePost.id == index
        }
        if let index = indexOfFavoritePost {
            favoritePosts.remove(at: index)
        }
        posts.remove(at: index)
    }
    
    mutating func removePostFromfavoriteWith(index: Int){
        let originalIndex = favoritePosts[index].id
        posts[originalIndex].isFavorite = false
        favoritePosts.remove(at: index)
    }
}

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

struct PostViewModel {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    var isFavorite: Bool
}

struct FavoritePostViewModel {
    let post: PostViewModel
    let id: Int
}


//
//  PostDetailViewModel.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//

import Foundation

struct PostDetailViewModel {
    let author: String
    let postTitle: String
    let postDescription: String
    let comments: [CommentViewModel]
    
    
}

struct CommentViewModel {
    let autor: String
    let comment: String
}

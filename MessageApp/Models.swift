//
//  Models.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//


import Foundation

// MARK: - Post
struct Post {
    let userID, id: Int
    let title, body: String
}

// MARK: - Comment
struct Comment {
    let postID, id: Int
    let name, email, body: String
}

// MARK: - User
struct User {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo {
    let lat, lng: String
}

// MARK: - Company
struct Company {
    let name, catchPhrase, bs: String
}

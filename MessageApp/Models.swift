//
//  Models.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 28/09/22.
//


import Foundation

struct Posts: Codable {
    var result: [Post]
}

// MARK: - Post
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// MARK: - Comment
struct Comment: Codable {
    let postID, id: Int
    let name, email, body: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

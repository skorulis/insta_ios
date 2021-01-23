//
//  InstaUser.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation

struct InstaUser: Decodable, Identifiable {
    
    let username: String
    let posts: Int?
    let followers: Int?
    let following: Int?
    let liked: String
    
    enum CodingKeys: String, CodingKey  {
        case username = "user_username"
        case posts = "user_posts"
        case followers = "user_followers"
        case following = "user_following"
        case liked = "count"
    }
    
    var id: String {
        return username
    }
}

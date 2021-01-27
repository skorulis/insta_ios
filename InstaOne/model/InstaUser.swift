//
//  InstaUser.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation

struct UserDetails: Decodable, Identifiable {
    let user: InstaUser
    let isFollowing: Bool
    let isFollower: Bool
    let likeCount: Int
    
    var id: String {
        return user.username
    }
}

struct InstaUser: Decodable, Identifiable {
    
    let username: String
    let postCount: Int?
    let followerCount: Int?
    let followingCount: Int?
    
    
    var id: String {
        return username
    }
}

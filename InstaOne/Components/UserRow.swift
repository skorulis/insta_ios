//
//  UserRow.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 24/1/21.
//

import Foundation
import SwiftUI

struct UserRow: View {
    
    private let user: UserDetails
    
    init(user: UserDetails) {
        self.user = user
    }
    
    var body: some View  {
        return HStack {
            Text(user.user.username)
            Text("\(user.likeCount)").multilineTextAlignment(.trailing)
            Text("Follower: \(user.isFollower ? "Y" : "N")")
        }
    }
    
}

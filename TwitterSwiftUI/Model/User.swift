//
//  User.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 17.01.2023.
//

import Foundation
import Firebase
struct User: Identifiable {
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let email: String
    var stats: UserStats
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == self.id
    }
    var isFollowed: Bool
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0)
        self.isFollowed = false
    }
}

struct UserStats {
    var followers: Int
    var following: Int
}

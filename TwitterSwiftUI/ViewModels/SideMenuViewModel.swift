//
//  SideMenuViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 25.01.2023.
//

import Foundation

class SideMenuViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        fetchUserStats()
    }
    func fetchUserStats() {
        
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followerCount = snapshot?.documents.count else { return }
            
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                
                self.user.stats = UserStats(followers: followerCount, following: followingCount)
            }
        }
    }    
}

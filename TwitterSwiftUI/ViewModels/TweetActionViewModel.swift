//
//  TweetActionViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 21.01.2023.
//

import Foundation
import Firebase

class TweetActionViewModel: ObservableObject {
    
    let tweet: Tweet
    @Published var didLike = false
    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        guard let uid = AuthViewModel.instance.userSession?.uid else { return }
        let tweetLikeRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
        let userLikeRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes + 1]) { error in
            tweetLikeRef.document(uid).setData([:]) { error in
                userLikeRef.document(self.tweet.id).setData([:]) { _ in
                    
                }
            }
        }
    }
    
    func unlikeTweet() {
        guard let uid = AuthViewModel.instance.userSession?.uid else { return }
        let tweetLikeRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
        let userLikeRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes - 0]) { error in
            tweetLikeRef.document(uid).delete { _ in
                userLikeRef.document(self.tweet.id).delete { _ in
                    
                }
            }
        }
    }
    
    
    func checkIfUserLikedTweet() {
        guard let uid = AuthViewModel.instance.userSession?.uid else { return }
        let userLikeRef = COLLECTION_USERS.document(uid).collection("user-likes").document(tweet.id)
        
        userLikeRef.getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
    }
}

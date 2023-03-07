//
//  TweetDetailViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 27.01.2023.
//

import SwiftUI


class TweetDetailViewModel: ObservableObject {
    
    @Published var tweet: Tweet?
    @Published var replies: [Tweet] = []
    let tweetIn: Tweet
    init(tweet: Tweet) {
        self.tweetIn = tweet
        self.fetchTweet(tweet.caption)
        fetchReplies()
        
    }
    func fetchTweet(_ caption: String) {
       
        COLLECTION_TWEETS.getDocuments { snapshot, error in
            
            if let snapshot = snapshot?.documents {
                let tweets = snapshot.map({ Tweet(dictionary: $0.data())})
                for tweet in tweets {
                    if tweet.caption == caption {
                        self.tweet = tweet
                    }
                }
            } else {
                print("DEBUG:", error?.localizedDescription)
            }                
        }
    }
    
    func fetchReplies() {
        COLLECTION_TWEETS.document(tweetIn.id).collection("tweet-replies").getDocuments { snapshot, error in
            if let snapshot = snapshot?.documents {
                let replies = snapshot.map({ Tweet(dictionary: $0.data())})
                self.replies = replies
                print(replies)
            }
        }
    }
}

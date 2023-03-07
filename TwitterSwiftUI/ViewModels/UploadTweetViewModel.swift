//
//  UploadTweetViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 21.01.2023.
//



import Foundation
import Firebase
class UploadTweetViewModel: ObservableObject {
    @Published var tweet: String?
    func uploadTweet(caption: String) {
        guard let user = AuthViewModel.instance.user else { return }
        let docRef = COLLECTION_TWEETS.document()
        
        // Create Date
        let date = Date()

        // Create Date Formatter


        // Convert Date to String
        
        
        let data: [String: Any] = ["uid": user.id, "caption": caption, "fullname": user.fullname, "timestamp": Timestamp(date: date) , "username": user.username, "profileImageUrl": user.profileImageUrl, "likes": 0, "id": docRef.documentID]
      
        docRef.setData(data) { _ in
            print("DEBUG: Successfully uploaded tweet: \(caption)")
        }
    }
    

}
 
class UploadRelyViewModel: ObservableObject {
    let tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    func uploadReply(reply: String) {
        guard let user = AuthViewModel.instance.user else { return }
        guard let uid = AuthViewModel.instance.userSession?.uid else { return }
        let docRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-replies").document()
        let userRef = COLLECTION_USERS.document(uid).collection("user-replies").document()
        let date = Date()
        
        let data: [String: Any] = ["uid": user.id, "caption": reply, "fullname": user.fullname, "timestamp": Timestamp(date: date) , "username": user.username, "profileImageUrl": user.profileImageUrl, "likes": 0, "id": docRef.documentID]
        
        docRef.setData(data) { _ in
            userRef.setData(data) { _ in
                print("DEBUG: Successfully uploaded reply: \(reply)")
            }
        }
    }
}

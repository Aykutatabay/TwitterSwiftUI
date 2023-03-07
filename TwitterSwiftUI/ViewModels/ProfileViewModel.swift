//
//  ProfileViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 20.01.2023.
//

import SwiftUI
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userTweets: [Tweet] = []
    @Published var likedTweets: [Tweet] = []
    @Published var user: User
    @Published var replies: [Tweet] = []
    var cancellables = Set<AnyCancellable>()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetctUserTweets2()
        fetchLikedTweets2()
        fetchUserStats2()
        fetchAllReplies2()
    }
 
    
    func filterTweets(filter: FilterTweetOptions) -> [Tweet] {
        switch filter {
        case .tweet:
            return self.userTweets
        case .likes:
            return self.likedTweets
        case .replies:
            return self.replies
        
        }
    }
}





extension ProfileViewModel {
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWING.document(user.id).collection("user-followers")
        
        followingRef.document(user.id).setData([:]) { _ in
            followersRef.document(currentUid).setData([:]) { _ in
                withAnimation {
                    self.user.isFollowed = true
                }
                
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWING.document(user.id).collection("user-followers")
        
        followingRef.document(user.id).delete { _ in
            followersRef.document(currentUid).delete { _ in
                withAnimation {
                    self.user.isFollowed = false
                }
                
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            
            self.user.isFollowed = isFollowed
        }
    }
    
    
    /// FETCH USER TWEETS
    
    func fetctUserTweets2() {
        fetctUserTweets()
            .sink { _ in
                
            } receiveValue: { tweets in
                self.userTweets = tweets
            }
            .store(in: &cancellables)
    }
        
    func fetctUserTweets() -> AnyPublisher<[Tweet], Error> {
        
        Future<[Tweet], Error> { promise in
            COLLECTION_TWEETS.whereField("uid", isEqualTo: self.user.id).getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.map({ Tweet(dictionary: $0.data()) })
                promise(.success(tweets))
                
                /*
                 documents.forEach { document in
                     print("DEBUG: Doc data is \(document.data())")
                     let tweet = Tweet(dictionary: document.data())
                     self.userTweets.append(tweet)
                 }
                 */

            }
        }
        .eraseToAnyPublisher()
    }
    
    
    /// FETCH LIKED TWEETS
    
    func fetchLikedTweets2() {
        fetchLikedTweets()
            .sink { _ in
                
            } receiveValue: { tweetIds in
                tweetIds.forEach { id in
                    self.fetchLikedTweets3(ID: id)
                        .sink { _ in
                            
                        } receiveValue: { tweet in
                            self.likedTweets.append(tweet)
                        }
                }
            }
            .store(in: &cancellables)

    }
    
    func fetchLikedTweets3(ID: String) -> AnyPublisher<Tweet, Error> {
        
        Future<Tweet, Error> { promise in
            COLLECTION_TWEETS.document(ID).getDocument { snapshot, error in
                
                if let error = error {
                    promise(.failure(error))
                }
                guard let data = snapshot?.data() else { return }
                promise(.success(Tweet(dictionary: data)))
                
                self.likedTweets.append(Tweet(dictionary: data))
                
                
                let tweet = Tweet(dictionary: data)
                print("DEBUG User tweets \(tweet) ")
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchLikedTweets() -> AnyPublisher<[String], Error> {
        
        Future<[String], Error> { promise in
            COLLECTION_USERS.document(self.user.id).collection("user-likes").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let documents = snapshot?.documents else { return }
                
                
                let tweetIDs = documents.map({ $0.documentID })
                promise(.success(tweetIDs))
        }
        

            
            
            /*
             tweetIDs.forEach { ID in

             }
             */

        }
        .eraseToAnyPublisher()
    }
    
    
    /// FETCH USER STATS
    
    func fetchUserStats2() {
        fetchUserStats()
            .sink { _ in
                
            } receiveValue: { followers in
                self.fetchUserStats3()
                    .sink { _ in
                        
                    } receiveValue: { followings in
                        self.user.stats = UserStats(followers: followers, following: followings)
                    }
                    .store(in: &self.cancellables)

            }
            .store(in: &cancellables)

    }
    
    func fetchUserStats3() -> AnyPublisher<Int , Error>   {
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        return Future<Int , Error> { promise in
            followingRef.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let followingCount = snapshot?.documents.count else { return }
                promise(.success(followingCount))
                
                //self.user.stats = UserStats(followers: followerCount, following: followingCount)
            }
        }
        .eraseToAnyPublisher()


    }
    
    func fetchUserStats() -> AnyPublisher<Int , Error> {
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        return Future<Int, Error> { promise in
            followersRef.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let followerCount = snapshot?.documents.count else { return }
                promise(.success(followerCount))
                
                
                /*

                 */
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// FETCH REPLIES
    func fetchAllReplies2() {
        fetchAllReplies()
            .sink { _ in
                
            } receiveValue: { replies in
                self.replies = replies
                print(replies)
            }
            .store(in: &cancellables)

    }
    
    func fetchAllReplies() -> AnyPublisher<[Tweet], Error> {
        Future<[Tweet], Error> { promise in
            COLLECTION_USERS.document(self.user.id).collection("user-replies").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                if let snapshot = snapshot?.documents {
                    let replies = snapshot.map({ Tweet(dictionary: $0.data())})
                    promise(.success(replies))

                }
            }
        }
        .eraseToAnyPublisher()
    }
}

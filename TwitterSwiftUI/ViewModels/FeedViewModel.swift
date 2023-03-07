//
//  FeedViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 21.01.2023.
//

import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    
    var cancellable = Set<AnyCancellable>()
    init() {
        fetchTweets2()
    }
    func deleteTweet(_ id: String) {
        
        let delRef = COLLECTION_TWEETS
        
        delRef.getDocuments { snapshots, error in
            if let snapshots = snapshots?.documents {
                for snap in snapshots {
                    if snap.documentID == id {
                        snap.reference.delete()
                        print("DEBUG: tweet deleted succesfully")
                    }
                }
                
            } else {
                print("DEBUG: ", error?.localizedDescription)
            }
        }
    }
    
    func fetchTweets2() {
        fetchTweets()
            .sink { _ in
                
            } receiveValue: { tweets in
                self.tweets = tweets
            }
            .store(in: &cancellable)
        

    }
    
    func fetchTweets() -> AnyPublisher<[Tweet], Error> {
        
        Future<[Tweet], Error> { promise in
            COLLECTION_TWEETS.getDocuments { snapshot, error in
                
                if let snapshot = snapshot?.documents {
                    let tweets = snapshot.map({ Tweet(dictionary: $0.data())})
                    print("DEBUG: Tweets fetched successfully")
                    promise(.success(tweets))
                } else {
                    print("DEBUG: ERROR \(error?.localizedDescription ?? "")")
                    guard let error = error else { return }
                    promise(.failure(error))
                    
                }
                
            }
        }
        .eraseToAnyPublisher()

    }
    

}


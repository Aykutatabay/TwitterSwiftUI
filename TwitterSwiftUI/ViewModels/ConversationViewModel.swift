//
//  ConversationViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 24.01.2023.
//

import Foundation
class ConversationViewModel: ObservableObject {
    @Published var recentMessages: [Message] = []
    private var recentMessagesDictionary: [String: Message] = [:]
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.instance.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                let uid = change.document.documentID
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.recentMessagesDictionary[uid] = Message(dictionary: messageData, user: user)
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                    
                }
            }
        }
    }
}

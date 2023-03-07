//
//  ChatViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 23.01.2023.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class ChatViewModel: ObservableObject {
    let user: User
    @Published var messages: [Message] = []
    var cancellables = Set<AnyCancellable>()
    init(user: User) {
        self.user = user
        fetchMessages2()
    }
    
    func fetchMessages2() {
        fetchMessages()
            .sink { _ in
                
            } receiveValue: { changes in
                changes.forEach { change in
                    let messageData = change.document.data()
                    guard let fromId = messageData["fromId"] as? String else { return }
                    self.fetchMessages3(fromId: fromId)
                        .sink { _ in
                            
                        } receiveValue: { user in
                            self.messages.append(Message(dictionary: messageData, user: user))
                            self.messages.sort(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &cancellables)
    }
    
    
    func fetchMessages3(fromId: String) -> AnyPublisher<User, Error> {
        
        Future<User, Error> { promise in
            COLLECTION_USERS.document(fromId).getDocument { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let data = snapshot?.data() else { return }
                let user = User(dictionary: data)
                promise(.success(user))
            }
        }.eraseToAnyPublisher()

    }
    
    func fetchMessages() -> AnyPublisher<[DocumentChange], Error>  {
        let uid = AuthViewModel.instance.userSession?.uid
        
        let query = COLLECTION_MESSAGES.document(uid ?? "").collection(user.id)
        
        return Future<[DocumentChange], Error> { promise in
            query.addSnapshotListener { snapshot, error in
                guard let changes = snapshot?.documentChanges else { return }
                promise(.success(changes))

            }
        }
        .eraseToAnyPublisher()

    }
    
    func sendMessages(_ messageText: String) {
        guard let currentUid = AuthViewModel.instance.userSession?.uid else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(user.id).document()
        let receivingUserRef = COLLECTION_MESSAGES.document(user.id).collection(currentUid)
        let receivingRecentRef = COLLECTION_MESSAGES.document(user.id).collection("recent-messages")
        let currentRecentRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText, "id": messageID, "fromId": currentUid, "toId": user.id, "timestamp": Timestamp(date: Date())]
 
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        currentRecentRef.document(user.id).setData(data)
        receivingRecentRef.document(currentUid).setData(data)
        
        print("DEBUG: Message sended..")
        
        
        
    }
}



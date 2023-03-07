//
//  Message.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import Foundation
import Firebase
import SwiftUI


struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrent: Bool
}

let Mock_Messages: [MockMessage] = [
    .init(id: 0, imageName: "spiderman", messageText: "Hey !", isCurrent: false),
    .init(id: 1, imageName: "batman", messageText: "Hey !", isCurrent: true),
    .init(id: 2, imageName: "spiderman", messageText: "Whats Up ?", isCurrent: false),
    .init(id: 3, imageName: "spiderman", messageText: "Im okey, u ?", isCurrent: true),
    .init(id: 4, imageName: "spiderman", messageText: "Im okey too, thanks", isCurrent: false),
    .init(id: 5, imageName: "spiderman", messageText: "So fuck u !!", isCurrent: true)

]



struct Message: Identifiable {
    let text: String
    let user: User
    let toId: String
    let fromId: String
    let isFromCurrentUser: Bool
    let timestamp: Timestamp
    let id: String
    
    var chatPartnerId: String { return isFromCurrentUser ? toId : fromId }
    
    init(dictionary: [String: Any], user: User) {
        self.text = dictionary["text"] as? String ?? ""
        self.user = user
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
    }
}

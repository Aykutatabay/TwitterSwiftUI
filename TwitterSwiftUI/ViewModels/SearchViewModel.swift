//
//  SearchViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 19.01.2023.
//

import Foundation
import SwiftUI
import Firebase
import Combine

enum SearchViewModelConfiguration {
    case search
    case newMessage
}

struct CustomError: Error {
    
}

class SearchViewModel: ObservableObject {
    @Published var users: [User] = []
    private let config: SearchViewModelConfiguration
    
    var cancellables = Set<AnyCancellable>()
    init(config: SearchViewModelConfiguration) {
        self.config = config
        fetchUsers2(forConfig: config)
    }
    
    func fetchUsers2(forConfig config: SearchViewModelConfiguration) {
        self.fetchUsers()
            .sink { _ in
                
            } receiveValue: { users in
                switch config {
                case .newMessage:
                    self.users = users.filter({ !$0.isCurrentUser })
                case .search:
                    self.users = users
                }
            }
            .store(in: &cancellables)

    }
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        
        return Future<[User], Error> { promise in
            COLLECTION_USERS.getDocuments { snapshot, error in
                
                if let error = error {
                    promise(.failure(error))
                }
                
                guard let documents = snapshot?.documents else { return }
                let users = documents.map({ User(dictionary: $0.data()) })
                promise(.success(users))
                
                

            }
        }.eraseToAnyPublisher()
    }
    
    func filteredUsers(_ query: String) -> [User] {
        return users.filter { user in
            user.fullname.contains(query)
        }
    }
}  

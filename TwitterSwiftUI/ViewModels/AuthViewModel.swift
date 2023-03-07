//
//  AuthViewModel.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 17.01.2023.
//

import Combine
import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating: Bool = false
    @Published var error: Error?
    @Published var user: User?
    var cancellables = Set<AnyCancellable>()
    static let instance = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser3()
    }
    
    func logIn(withEmail: String, password: String) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log in: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Succesfully logged in")
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser3()
        }
    }
        
    
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Succesfully uploaded user photo...")
            
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    
                    let data = ["email": email,
                                "username": username.lowercased(),
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid]
                    
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        print("DEBUG: Succesfully uploaded user data...")
                        self.userSession = user
                        self.fetchUser3()
                    }
                    
                }
            }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    

    
    /*
     func fetchUser() {
         guard let uid = userSession?.uid else { return }
         
         
         Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
             
             if let error = error {
                 print("DEBUG: User not found \(error.localizedDescription)")
             }
             
             guard let data = snapshot?.data() else { return }
             self.user = User(dictionary: data)
             print("DEBUG: User is \(self.user?.username ?? "")")
         }
     }
     */
    func fetchUser3() {
        fetchUser2()
            .sink { _ in
                
            } receiveValue: { user in
                self.user = user
                print("DEBUG: FUTURE COMBINE WORKS")
            }
            .store(in: &cancellables)

    }
    
    func fetchUser2() -> AnyPublisher<User, Error> {
        let uid = userSession?.uid ?? ""
        
        return Future<User, Error>{ promise in
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
                
                if let error = error {
                    print("DEBUG: User not found \(error.localizedDescription)")
                    promise(.failure(error))
                }
                
                guard let data = snapshot?.data() else { return }
                
                
                promise(.success(User(dictionary: data)))
                print("DEBUG: User is \(self.user?.username ?? "")")
            }
        }
        .eraseToAnyPublisher()
    }
    
    func testCombine(_ value: Int) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            if value < 5 {
                promise(.success(true))
            }
            
            promise(.failure(CustomError.init()))
        }
        .eraseToAnyPublisher()
    }
}

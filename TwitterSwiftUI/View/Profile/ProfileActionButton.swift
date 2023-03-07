//
//  ProfileActionButton.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import SwiftUI

struct ProfileActionButton: View {
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button {

            } label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color:.black.opacity(0.5), radius: 10)
            }
        } else {
            HStack {
                Button {
                    withAnimation {
                        viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
                    }
                    
                } label: {
                    Text(viewModel.user.isFollowed ?  "Following" : "Follow")
                        .animation(.spring())
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(color:.black.opacity(0.5), radius: 10)
                }
                
                
                NavigationLink {
                    ChatView(user: viewModel.user)
                } label: {
                    Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(color:.black.opacity(0.5), radius: 10)
                }
            }
        }


    }
}

/*
 struct ProfileActionButton_Previews: PreviewProvider {
     static var previews: some View {
         ProfileActionButton(isCurrentUser: false)
     }
 }
 */


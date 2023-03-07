//
//  ConversationView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI
import Kingfisher

struct ConversationView: View {
    @State var isPresented: Bool = false
    @State var showChat: Bool = false
    @StateObject var viewModel: ConversationViewModel = ConversationViewModel()
    @State var user: User?
    var body: some View {
            ZStack(alignment: .bottomTrailing) {
                
                if let user = user {
                    NavigationLink(destination: ChatView(user: user), isActive: $showChat) {
                        Text("")
                    }
                }

                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.recentMessages) { message in
                            NavigationLink {
                                ChatView(user: message.user)
                            } label: {
                                ConversationCell(message: message)
                                    .accentColor(.black)
                            }

/*
 NavigationLink {
     Text("hello ")
 } label: {
     ConversationCell()
         .accentColor(.black)
 }
 */
                            
                        }
                        .padding(.vertical, 3)
                    }
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding()
                }
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $isPresented) {
                    NewMessageView(show: $isPresented, startChat: $showChat, user: $user)
                }
            }
            .navigationTitle("")
        }
    }


/*
 struct ConversationView_Previews: PreviewProvider {
     static var previews: some View {
         ConversationView()
     }
 }
 */


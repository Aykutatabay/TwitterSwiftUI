//
//  ChatView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI
import Kingfisher

struct ChatView: View {
    @State var messageText: String = ""
    let user: User
    @StateObject var viewModel: ChatViewModel
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages) { massage in
                        MessageView(massage: massage)
                    }
                    Spacer()
                }
            }
            MessageInputView(messageText: $messageText, action: {
                viewModel.sendMessages(messageText)
                messageText = ""
            })
                .padding()
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
 struct ChatView_Previews: PreviewProvider {
     static var previews: some View {
         ChatView()
     }
 }
 
 */


struct MessageView: View {
    
    let massage: Message
    var body: some View {
        HStack {
            if massage.isFromCurrentUser {
                Spacer()
                Text(massage.text)
                    .padding(15)
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: massage.isFromCurrentUser))
                    .padding(.trailing)
                    .foregroundColor(.white)
            }
            else {
                HStack(alignment: .bottom) {
                    KFImage(URL(string: massage.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                    Text(massage.text)
                        .padding(15)
                        .background(Color(.systemGray5))
                        .clipShape(ChatBubble(isFromCurrentUser: massage.isFromCurrentUser))
                        .padding(.trailing)
                        .foregroundColor(.black)
                }.padding(.horizontal)
                Spacer()
            }
        }
        
    }
}

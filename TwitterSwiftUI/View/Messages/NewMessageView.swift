//
//  NewMessageView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)
    @Binding var user: User?
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: $text)
                    .padding(7)
                
                VStack(alignment: .leading) {
                    ForEach(text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)) { user in
                        HStack {
                            Button {
                                self.show.toggle()
                                self.startChat.toggle()
                                self.user = user
                            } label: {
                                UserCell(user: user)
                                    .accentColor(.black)
                            }                                
                            Spacer()
                        }
                    }
                }
                .padding(.leading, 5)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "xmark")
                        .font(.body)
                        .padding(.leading, 7)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
}

/*
 struct NewMessageView_Previews: PreviewProvider {
     static var previews: some View {
         NewMessageView(show: .constant(true), startChat: .constant(true))
     }
 }
 */


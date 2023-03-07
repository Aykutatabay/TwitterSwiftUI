//
//  ewTweetView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    let placeHolderText: String = "Whats happening ?"
    @EnvironmentObject var feedVM: FeedViewModel
    @ObservedObject var tweetViewModel = UploadTweetViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if let stringImage = AuthViewModel.instance.user?.profileImageUrl {
                        KFImage(URL(string: stringImage))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                    } else {
                        Image("batman")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
                    
                    TextArea(text: $text, placeHolderText)
                    
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.systemBlue))
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            tweetViewModel.uploadTweet(caption: text)
                            presentationMode.wrappedValue.dismiss()
                            feedVM.fetchTweets()
                            
                        } label: {
                            Text("Tweet")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 18)
                                .background(.blue)
                                .cornerRadius(25)
                        }
                        
                    }
                }
                Spacer()
            }
        }
    }
}

/*
 struct NewTweetView_Previews: PreviewProvider {
     static var previews: some View {
         NewTweetView()
     }
 }
 */


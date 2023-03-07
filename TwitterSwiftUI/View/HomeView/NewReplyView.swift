//
//  NewReplyView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 27.01.2023.
//

import SwiftUI
import Kingfisher

struct NewReplyView: View {
    let tweet: Tweet
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    let placeHolderText: String = "Tweet your reply"
    @EnvironmentObject var feedVM: FeedViewModel
    @ObservedObject var tweetViewModel = UploadTweetViewModel()
    let uploadReplyVM: UploadRelyViewModel
    init(tweet: Tweet) {
        self.tweet = tweet
        self.uploadReplyVM = UploadRelyViewModel(tweet: tweet)
    }
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text("Replying to")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text("@\(tweet.username)")
                        .foregroundColor(.blue)
                    Spacer()
                }.padding()
                
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
                            uploadReplyVM.uploadReply(reply: text)
                            presentationMode.wrappedValue.dismiss()
                            
                            
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


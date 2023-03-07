//
//  TweetDetailView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 21.01.2023.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    let details: Tweet
    @StateObject var viewModel: TweetDetailViewModel
    @State private var showReply: Bool = false
    
    init(details: Tweet) {
        self.details = details
        _viewModel = StateObject(wrappedValue: TweetDetailViewModel(tweet: details))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                if let imageString = details.profileImageUrl {
                    KFImage(URL(string: imageString))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                } else {
                    Image("batman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(details.fullname)
                        .font(.system(size: 14, weight: .semibold))
                        
                    
                    Text("@\(details.username)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                }
            }
            
            Text(details.caption)
                .font(.system(size: 22))
            
            Text("\(details.timestamp)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Divider()
            
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Retweets")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                HStack(spacing: 4) {
                    Text("\(viewModel.tweet?.likes ?? 22)")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Likes")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                }
            }
            Divider()
            
            if let tweet = viewModel.tweet {
                TweetActionView(tweet: tweet, showReply: $showReply)
                    .padding(.top, -7)
                    .padding(.bottom, -7)
            }
            Divider()
            if !viewModel.replies.isEmpty {
                ForEach(viewModel.replies) { reply in
                    ReplyCell(reply: reply)
                }
            }
            
            
            Spacer()
            
        }.padding()
            .fullScreenCover(isPresented: $showReply) {
                NewReplyView(tweet: details)
            }
        }
    }

/*
 struct TweetDetailView_Previews: PreviewProvider {
     static var previews: some View {
         TweetDetailView()
     }
 }
 */


//
//  TweetActionView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 27.01.2023.
//

import SwiftUI


struct TweetActionView: View {
    let tweet: Tweet
    @ObservedObject var viewModel: TweetActionViewModel
    @Binding var showReply: Bool
    init(tweet: Tweet, showReply: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: TweetActionViewModel(tweet: tweet))
        self.tweet = tweet
        self._showReply = showReply
        
    }
    var body: some View {
        HStack {
            Button {
                showReply.toggle()
            } label: {
                Image(systemName: "bubble.left")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {
                
                print("Button mode 1",viewModel.didLike.description)
                withAnimation {
                    viewModel.didLike ? viewModel.unlikeTweet() : viewModel.likeTweet()
                }
                viewModel.didLike.toggle()
                print("Button mode 2",viewModel.didLike.description)
            } label: {
                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.didLike ? .red : .gray)
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bookmark")
                
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
        }
        .foregroundColor(.gray)
    }
}


struct ReplyActionView: View {
    var body: some View {
        HStack {
            Button {
            } label: {
                Image(systemName: "bubble.left")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {

            } label: {
                Image(systemName:"heart")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bookmark")
                
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            }
        }
        .foregroundColor(.gray)
    }
}

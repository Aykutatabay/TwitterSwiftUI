//
//  TweetCell.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    let tweetInfo: Tweet
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                if let imageString = tweetInfo.profileImageUrl {
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
                VStack(alignment: .leading) {
                    HStack {
                        Text(tweetInfo.fullname)
                            .font(.system(size: 14, weight: .semibold))
                            .fontWeight(.heavy)
                        Text("@\(tweetInfo.username) .")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.leading, 5)
                        
                        Text(formatDate(date: Date.now))
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("...")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    
                    Text(tweetInfo.caption)
                        .font(.system(size: 15))
                    
                    TweetActionView(tweet: tweetInfo, showReply: .constant(false))
                }
            }
            Divider()
                
        }
        .padding(.horizontal, 5)
        
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

/*
 struct TweetCell_Previews: PreviewProvider {
     static var previews: some View {
         TweetCell()
     }
 }
 */



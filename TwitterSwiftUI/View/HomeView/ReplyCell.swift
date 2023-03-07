//
//  ReplyCell.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 28.01.2023.
//

import SwiftUI
import Kingfisher

struct ReplyCell: View {
    let reply: Tweet
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: reply.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(reply.fullname)
                            .font(.system(size: 14, weight: .semibold))
                            .fontWeight(.heavy)
                        Text("@\(reply.username).")
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
                    
                    Text(reply.caption)
                        .font(.system(size: 15))
                    
                    ReplyActionView()
                }
            }
            Divider()
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

/*
 
 */


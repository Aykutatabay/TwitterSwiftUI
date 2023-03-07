//
//  ConversationCell.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    let message: Message
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                KFImage(URL(string: message.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 56, height: 56)
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.user.fullname)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message.text)
                        .font(.system(size: 15))
                        .lineLimit(1)

                }
                .frame(height: 64)
                .padding(.trailing)
            }
            Divider()
        }
    }
}

/*
 struct ConversationCell_Previews: PreviewProvider {
     static var previews: some View {
         ConversationCell()
     }
 }

 */

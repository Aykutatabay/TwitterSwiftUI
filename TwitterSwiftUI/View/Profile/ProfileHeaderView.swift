//
//  ProfileHeaderView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {
        VStack(spacing: 2) {
            image
            texts
            Spacer()
        }        
    }
}


extension ProfileHeaderView {
    private var image: some View {
        KFImage(URL(string: viewModel.user.profileImageUrl))
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 120, height: 120)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.gray)
                    .opacity(0.2)
                    .frame(width: 130, height: 130)
            }
            .shadow(color: .black, radius: 10, x: 0, y: 0)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .opacity(0.3)
                    .frame(width: 125, height: 125)
            }
            .padding(.bottom, 7)
    }
    
    private var texts: some View {
        VStack {
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray2))
            
            Text("Hello I am \(viewModel.user.username) and new on Twitter :)")
                .font(.system(size: 14))
                .padding(.top, 8)            
            
            HStack(spacing: 40) {
                VStack {
                    Text("\(viewModel.user.stats.followers)")
                        .font(.system(size: 16, weight: .bold))
                    Text("Followers")
                         .font(.footnote)
                         .foregroundColor(.gray)
                }
                                
                VStack {
                    Text("\(viewModel.user.stats.following)")
                         .font(.system(size: 16, weight: .bold))
                     Text("Following")
                          .font(.footnote)
                          .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}

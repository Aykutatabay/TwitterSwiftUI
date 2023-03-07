//
//  SideMenuView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 25.01.2023.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var sideVM: SideMenuViewModel
    
    init(user: User) {
        _sideVM = StateObject(wrappedValue: SideMenuViewModel(user: user))
    }
    var body: some View {
        
        ZStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(sideVM.user.fullname)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 0)
                        .foregroundColor(.white)
                    Text("@ \(sideVM.user.username)" )
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray2))
                        .padding(.top, 1)
                    HStack {
                        Text("\(sideVM.user.stats.following)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Text("Following")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        Text("\(sideVM.user.stats.followers)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Text("Followers")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 1)
                    
                    NavigationLink {
                        UserProfileView(user: sideVM.user)
                    } label: {
                        HStack {
                            Image(systemName: "person")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text("Profile")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 15)
                    }
                    
                    HStack {
                        Image(systemName: "bookmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Bookmarks")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 12)
                    HStack {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Topics")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top,12)
                    HStack {
                        Image(systemName: "gear")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Settings")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 12)
                    
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Logout")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        authVM.signOut()
                    }
                    .padding(.top, 12)
                    Spacer()
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            
        }
        .background(Color.black)
    }
}

/*
 struct SideMenuView_Previews: PreviewProvider {
     static var previews: some View {
         SideMenuView()
     }
 }
 */


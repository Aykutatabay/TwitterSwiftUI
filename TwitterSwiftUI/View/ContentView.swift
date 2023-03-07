//
//  ContentView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import Combine
import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    @State private var sideMenu: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var searchViewText: String = ""
//    @State private var subscriptions = Set<AnyCancellable>()
    @State private var isLoading: Bool = false
    
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else {
                Group {
                    if viewModel.userSession != nil {
                        NavigationView {
                            ZStack(alignment: .leading) {
                                TabView(selection: $selectedIndex) {
                                    FeedView()
                                        .padding(.top, -10)
                                        .tabItem {
                                            Image(systemName: "house")
                                            Text("Home")
                                        }
                                        .onTapGesture {
                                            self.selectedIndex = 0
                                            
                                        }
                                        .tag(0)
                                    
                                    SearchView(text: $searchViewText)
                                        .tabItem {
                                            Image(systemName: "magnifyingglass")
                                            Text("Search")
                                        }
                                        .onTapGesture {
                                            self.selectedIndex = 1
                                            
                                        }
                                        .tag(1)
                                    
                                    ConversationView()
                                        .tabItem {
                                            Image(systemName: "envelope")
                                            Text("Message")
                                        }
                                        .onTapGesture {
                                            self.selectedIndex = 2
                                            
                                        }
                                        .tag(2)
                                }
                                .disabled(sideMenu)
                                .blur(radius: sideMenu ? 5 : 0)
                                .offset(x: sideMenu ? 300 : 0)
                                
                                if let user = viewModel.user {
                                    SideMenuView(user: user)
                                        .frame(width: 300)
                                        .offset(x: sideMenu ? 0 : -300)
                                }
                            }
                            .toolbar {
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    
                                    if selectedIndex == 1 {
                                        Image(systemName: "gear")
                                            .padding(7)
                                    } else if selectedIndex == 2 {
                                        Image(systemName: "gear")
                                    }
                                    
                                    Image(systemName: "star")
                                }
                                
                                ToolbarItem(placement: .principal) {
                                    
                                    if selectedIndex == 1 {
                                        SearchBar(searchText: $searchViewText)
                                            .padding(7)
                                            .opacity(sideMenu ? 0 : 1)
                                    } else if selectedIndex == 2 {
                                        Text("Messages")
                                            .opacity(sideMenu ? 0 : 1)
                                    }
                                    
                                    
                                    Image("twitterlogoblue.svg")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20,height: 20)
                                }
                                
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        //viewModel.signOut()
                                        withAnimation {
                                            sideMenu.toggle()
                                        }
                                        
                                    } label: {
                                        if let imageString = viewModel.user?.profileImageUrl {
                                            KFImage(URL(string: imageString))
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 25, height: 25)
                                        } else {
                                            ProgressView()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                }
                            }
                        }

                    }
                    else {
                        LoginView()
                    }
                }
            }
            
        }
        /*
         .onAppear {
             viewModel
                 .testCombine(3)
                 .handleEvents(receiveSubscription: { _ in
                     isLoading = true
                     print("AYKUT::: STARTED")
                 }, receiveOutput: { _ in
                     print("AYKUT::: OUTPUT")
                 }, receiveCompletion: { compleiton in
                     isLoading = false
                     print("AYKUT::: FINISHED")
                 }, receiveCancel: {
                     
                 }, receiveRequest: { _ in
                     
                 })
                 .sink { completion in
                     switch completion {
                     case .finished:
                         print("FINISHED")
                     case .failure(let error):
                         print("ERROR: ", error.localizedDescription)
                     }
                 } receiveValue: { biggerThan5 in
                     if biggerThan5 {
                         print("BIGGER")
                     } else {
                         print("NOT BIGGER")
                     }
                 }
                 .store(in: &subscriptions)
         }
         */
    }
}


/*

 */

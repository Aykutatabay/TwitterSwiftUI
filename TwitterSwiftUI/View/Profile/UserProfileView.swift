//
//  UserProfileView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import SwiftUI



struct UserProfileView: View {
    @State private var seletedFilter: FilterTweetOptions = .tweet
    let user: User
    @StateObject var viewModel: ProfileViewModel
    @EnvironmentObject var feedVM: FeedViewModel
    @State var action: Bool = false
    @State private var tweetId: String = ""
    @State private var showAlert: Bool = false
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
        
        
    }
    var body: some View {
            ScrollView {
                ProfileHeaderView(viewModel: viewModel)
                    .padding(.top)
                
                ProfileActionButton(viewModel: viewModel)
                
                FilterButtonView(seletedFilter: $seletedFilter)
                    .padding()
                ForEach(viewModel.filterTweets(filter: seletedFilter)) { tweet in
                        TweetCell(tweetInfo: tweet)
                            .accentColor(.black)
                            .onLongPressGesture {
                                self.tweetId = tweet.id
                                self.action.toggle()
                            }
                            .padding(.horizontal)
                    
                }
                

            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .actionSheet(isPresented: $action) {
                getActionSheet()
                
            }
            .alert(isPresented: $showAlert) {
                getAlert(tweetId)
            }
    }
    
    func getActionSheet() -> ActionSheet {
        let shareButton: ActionSheet.Button = .default(Text("Share"), action: {
            
        })
        let reportButton: ActionSheet.Button = .destructive(Text("Report"))  {
            
        }
        let deleteButton: ActionSheet.Button = .destructive(Text("Delete")) {
            showAlert.toggle()
        }
        let cancelButton: ActionSheet.Button = .cancel()
        let title = Text("what would you like to do ?")
        
        return ActionSheet(title: title,
                           message: nil,
                           buttons: [shareButton, reportButton, deleteButton, cancelButton])
        
    }
    
    func getAlert(_ id: String) -> Alert {
        return Alert(title: Text("Do you want to delete this tweet"),
                     primaryButton: .destructive(Text("Delete"), action: { feedVM.deleteTweet(id)  }),
                     secondaryButton: .cancel())
    }
}

/*
 struct UserProfileView_Previews: PreviewProvider {
     static var previews: some View {
         UserProfileView()
     }
 }
 */
 


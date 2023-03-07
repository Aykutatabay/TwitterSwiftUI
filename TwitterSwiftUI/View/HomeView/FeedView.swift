//
//  FeedView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @State private var isShowingNewTweetView: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var feedVM: FeedViewModel
    @State var action: Bool = false
    @State var actionSheetOptions: ActionSheetOption = .myPost
    @State private var tweetId: String = ""
    @State private var showAlert: Bool = false
    enum ActionSheetOption {
        case myPost
        case otherPost
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(feedVM.tweets) { tweet in
                            NavigationLink{
                                TweetDetailView(details: tweet)
                            } label: {
                                TweetCell(tweetInfo: tweet)
                                    .accentColor(.black)
                                    .onLongPressGesture {
                                        actionSheetOptions = tweet.uid == viewModel.user?.id ? .myPost : .otherPost
                                        self.tweetId = tweet.id
                                        self.action.toggle()
                                    }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            
            Button {
                isShowingNewTweetView.toggle()
                //viewModel.signOut()
            } label: {
                Image("Tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
        }
        .fullScreenCover(isPresented: $isShowingNewTweetView) {
            NewTweetView()
        }
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
        
        
        switch actionSheetOptions {
        case .myPost:
            return ActionSheet(title: title,
                               message: nil,
                               buttons: [shareButton, reportButton, deleteButton, cancelButton])
        case .otherPost:
            return ActionSheet(title: title,
                               message: nil,
                               buttons: [shareButton, reportButton, cancelButton])
        }
        
    }
    
    func getAlert(_ id: String) -> Alert {
        return Alert(title: Text("Do you want to delete this tweet"),
                     primaryButton: .destructive(Text("Delete"), action: { feedVM.deleteTweet(id)  }),
                     secondaryButton: .cancel())
    }
}


/*
 struct FeedView_Previews: PreviewProvider {
     static var previews: some View {
         FeedView()
     }
 }
 */


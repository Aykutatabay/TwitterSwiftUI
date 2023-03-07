//
//  SearchView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    var body: some View {
            ScrollView {

                
                VStack(alignment: .leading) {
                    ForEach(text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)) { user in
                        HStack {
                            NavigationLink {
                                UserProfileView(user: user)
                            } label: {
                                UserCell(user: user)
                                    .accentColor(.black)
                            }

                                
                            Spacer()
                        }
                    }
                }
                .padding(.leading, 5)
            }
    }
}

/*
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
*/

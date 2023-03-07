//
//  SearchBar.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 14.01.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Search... ", text: $searchText)
                .padding(7)
                .padding(.leading, 35 )
                .foregroundColor(.black.opacity(0.4))
                .background(Color.gray.opacity(0.25))
                .cornerRadius(17)
                .padding(.horizontal, 5)
                
            Image(systemName: "magnifyingglass")
                .padding(.horizontal, 20)
                .foregroundColor(.black.opacity(0.4))
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("Search..."))
    }
}

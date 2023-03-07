//
//  FilterButtonView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 15.01.2023.
//

import SwiftUI
enum FilterTweetOptions: Int, CaseIterable {
    case tweet
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweet :
            return "Tweets"
        case .replies:
            return "Tweets & replies"
        case .likes:
           return "Likes"
        }
    }
}


struct FilterButtonView: View {
    @Binding var seletedFilter: FilterTweetOptions
    var body: some View {
        HStack(spacing: 0) {
            ForEach(FilterTweetOptions.allCases, id: \.self) { item in
                VStack(alignment: .center) {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemBlue))
                        .shadow(radius: 0.5)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.seletedFilter = item
                            }
                        }
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 3.3  , height: 3)
                            .foregroundColor(self.seletedFilter == item ? Color(.systemBlue) : .white)
                            .cornerRadius(20)
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 3, height: 0.5)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(seletedFilter: .constant(.tweet))
    }
}

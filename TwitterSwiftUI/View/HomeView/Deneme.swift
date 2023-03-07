//
//  Deneme.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 7.02.2023.
//

import SwiftUI
import Kingfisher

struct Deneme: View {
    var body: some View {
        KFImage(URL(string: "https://image.tmdb.org/t/p/w500//sv1xJUazXeYqALzczSZ3O6nkH75.jpg"))
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 200)
    }
}

struct Deneme_Previews: PreviewProvider {
    static var previews: some View {
        Deneme()
    }
}

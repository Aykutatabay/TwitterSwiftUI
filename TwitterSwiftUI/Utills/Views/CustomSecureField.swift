//
//  CustomSecureField.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    var body: some View {        
        ZStack(alignment: .leading) {
            
            if text.isEmpty {
                placeholder
                    .foregroundColor(.white)
                    .padding(.leading, 33)
            }
            HStack(spacing: 16) {
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                
                SecureField("", text: $text)  
                    .foregroundColor(.white)
            }
        }
    }
}


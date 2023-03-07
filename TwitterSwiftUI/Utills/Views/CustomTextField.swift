//
//  CustomTextField.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI

struct CustomTextField: View {
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
                
                TextField("", text: $text)
                    .foregroundColor(.white)
            }
        }
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: Text("Email"), imageName: "lock")
    }
}

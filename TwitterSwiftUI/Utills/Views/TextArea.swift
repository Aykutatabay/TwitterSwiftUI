//
//  TextArea.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    init(text: Binding<String>, _ placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
            /*
             if text == "" {
                 Text(placeholder)
                     .foregroundColor(Color(.placeholderText))
                     .padding(.horizontal, 8)
                     .padding(.vertical, 12)
             } else {
                 TextEditor(text: $text)
                     .padding(4)
                     .font(.body)
             }
             */

        }
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea(text: .constant("Aykut"), "ATABAY")
    }
}

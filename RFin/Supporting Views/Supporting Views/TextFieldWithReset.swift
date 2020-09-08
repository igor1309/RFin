//
//  TextFieldWithReset.swift
//  Restaurants
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TextFieldWithReset: View {
    var title: String
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TextField(title, text: $text)
            
            Button(action: {
                //  MARK: TODO put focus (cursor) to TextField
                withAnimation { self.text = "" }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                    .padding(EdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 8))
                    .opacity(text.isEmpty ? 0 : 0.8)
                    .animation(.default)
            }
        }
    }
}

struct TextFieldWithReset_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                TextFieldWithReset("", text: .constant("jfbv ah"))
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

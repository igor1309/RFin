//
//  SourceWebView.swift
//  RFin
//
//  Created by Igor Malyarov on 22.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import WebKit

struct SourceWebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

struct SourceWebView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SourceWebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

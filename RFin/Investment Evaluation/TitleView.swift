//
//  TitleView.swift
//  Investment Evaluation
//
//  Created by Igor Malyarov on 20.07.2020.
//

import SwiftUI

struct TitleView: View {
    var title: String
    
    init(_ text: String) {
        title = text
    }
    
    var body: some View {
        Text(title)
            .foregroundColor(.orange)
            .font(.title)
            .padding(.vertical)
        
//        Divider().padding(.vertical)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView("Some title")
            .preferredColorScheme(.dark)
    }
}

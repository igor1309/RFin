//
//  Row.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowWithDetail: View {
    let systemName: String
    let title: String
    let detail: String
    var isSecondary = false
    
    var body: some View {
        HStack {
            Group {
                if systemName.isEmpty {
                    Text(title)
                } else {
                    Label(title, systemImage: systemName)
                }
            }
            .foregroundColor(isSecondary ? .secondary : .primary)
            .layoutPriority(9)
            Spacer()
                .layoutPriority(3)
            Text(detail)
                .foregroundColor(Color(UIColor.systemOrange))
                .layoutPriority(9)
        }
    }
}

struct Row: View {
    var title: String
    var detail: String
    var isSecondary = false
    
    var body: some View {
        Group {
            Text(title)
                .foregroundColor(isSecondary ? .secondary : .primary)
                .layoutPriority(9)
            Spacer()
                .layoutPriority(3)
            Text(detail)
                .foregroundColor(Color(UIColor.systemOrange))
                .layoutPriority(9)
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            HStack {
                Row(title: "Title", detail: "detail")
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

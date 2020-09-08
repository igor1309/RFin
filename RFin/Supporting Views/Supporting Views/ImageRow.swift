//
//  ImageRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ImageRow: View {
    var image: String = ""
    var title: String
    var detail: String
    var isHighlighted = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if image.isNotEmpty {
                Image(systemName: image).frame(minWidth: 24, alignment: .center)
            }
            
            Text(verbatim: title)
            
            Spacer()
            
            if isHighlighted {
                Text(detail).foregroundColor(.systemOrange)
            } else {
                Text(detail)
            }
        }
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ImageRow(image: "briefcase", title: "Budget", detail: "€" + 100_000.formattedGrouped)
                ImageRow(image: "person.2", title: "Sales", detail: 1_000.formattedGrouped, isHighlighted: true)
                ImageRow(image: "tornado", title: "Conversion", detail: 0.001.formattedPercentageWithDecimals)
                ImageRow(image: "", title: "No Image Row", detail: 0.001.formattedPercentageWithDecimals)
                ImageRow(title: "No Image Row 2", detail: 0.001.formattedPercentageWithDecimals, isHighlighted: true)
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

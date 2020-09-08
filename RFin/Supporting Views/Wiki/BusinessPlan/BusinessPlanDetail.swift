//
//  BusinessPlanDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 22.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct BusinessPlanDetail: View {
    var name: String
    var description: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Group {
                Text(name)
                    .font(.headline)
                    .padding([.horizontal, .bottom])
                    .foregroundColor(.systemPurple)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationBarTitle(name)
    }
}

struct BusinessPlanDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BusinessPlanDetail(name: sampleBusinessPlan.sections[0].name, description: sampleBusinessPlan.sections[1].description)
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

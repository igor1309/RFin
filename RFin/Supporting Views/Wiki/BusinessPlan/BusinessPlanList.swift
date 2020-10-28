//
//  BusinessPlanList.swift
//  RFin
//
//  Created by Igor Malyarov on 22.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct BusinessPlanList: View {
    @State private var isExpanded = false
    
    var body: some View {
        List {
            ForEach(sampleBusinessPlan.sections) { section in
                
                Section(header: Text(section.name).foregroundColor(.systemPurple)) {
                    
                    NavigationLink(destination: BusinessPlanDetail(name: section.name, description: section.description)) {
                        
                        Text(section.description)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                }
            }
            
            NavigationLink(destination: SourceWebView(request: URLRequest(url: URL(string: "https://www.webstaurantstore.com/article/420/restaurant-business-plan.html")!))) {
                Text("Source")
                    .foregroundColor(.accentColor)
            }
        }
        .listStyle(InsetGroupedListStyle())            
        .navigationBarTitle("Business Plan")
    }
}

struct BusinessPlanList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BusinessPlanList()
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

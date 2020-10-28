//
//  ListRowWithSheet.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI
import SwiftPI

struct ListRowWithSheet<T: View>: View {
    
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let sheet: () -> T
    
    init(
        icon: String,
        title: String,
        subtitle: String,
        color: Color,
        @ViewBuilder sheet: @escaping () -> T
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.color = color
        self.sheet = sheet
    }
    
    @State private var showSheet = false
    
    @ViewBuilder
    var label: some View {
        HStack(spacing: 0) {
            Label {
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .padding(.top, 3)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            } icon: {
                Image(systemName: icon)
                    .offset(y: 3)
            }
            
            Spacer()
        }
        .foregroundColor(color)
        .contentShape(Rectangle())
    }
    
    var body: some View {
        label
            .onTapGesture { showSheet = true }
            .sheet(isPresented: $showSheet) { sheet() }
    }
}

struct ListRowWithSheet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                List {
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "Subtitle", color: .systemTeal) {
                        Text("Test Sheet")
                    }
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "This is a longer Subtitle to test subtitle row in full lengths and extimate multiline formatting.", color: .systemOrange) {
                        Text("Test Sheet")
                    }
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "", color: .purple) {
                        Text("Test Sheet")
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                List {
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "Subtitle", color: .systemTeal) {
                        Text("Test Sheet")
                    }
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "This is a longer Subtitle to test subtitle row in full lengths and extimate multiline formatting.", color: .systemOrange) {
                        Text("Test Sheet")
                    }
                    ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "", color: .purple) {
                        Text("Test Sheet")
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .previewDevice("iPad Pro (11-inch) (2nd generation)")
            .preferredColorScheme(.dark)
        }
    }
}

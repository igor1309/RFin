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
    
    init(icon: String, title: String, subtitle: String, color: Color, @ViewBuilder sheet: @escaping () -> T) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.color = color
        self.sheet = sheet
    }
    
    @State private var showSheet = false
    
    @ViewBuilder
    var label: some View {
        if subtitle.isEmpty {
            Label(title, systemImage: icon)
        } else {
            Label {
                VStack (alignment: .leading, spacing: 4) {
                    Text(title)
                        .padding(.top, 3)
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            } icon: {
                Image(systemName: icon)
                    .offset(y: 3)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            label
            Spacer()
        }
            .foregroundColor(color)
            .contentShape(Rectangle())
            .onTapGesture { showSheet = true }
            .sheet(isPresented: $showSheet) { sheet() }
    }
}

struct ListRowWithSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "Subtitle", color: .systemTeal) {
                    Text("Test Sheet")
                }
                ListRowWithSheet(icon: "tornado", title: "Title", subtitle: "", color: .systemTeal) {
                    Text("Test Sheet")
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .preferredColorScheme(.dark)
    }
}

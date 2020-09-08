//
//  CustomToggle.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CustomToggle: View {
    var title: String
    @Binding var isOn: Bool
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(isOn ? .primary : .secondary)
            Spacer()
            Text(isOn ? "On" : "Off")
                .foregroundColor(.systemOrange)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if hapticsAvailable {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            self.isOn.toggle()
        }
    }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CustomToggle(title: "Simple Custom Toggle", isOn: .constant(true))
                CustomToggle(title: "Simple Custom Toggle", isOn: .constant(false))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

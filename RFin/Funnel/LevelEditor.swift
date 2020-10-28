//
//  LevelEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LevelEditor: View {
    @Binding var draft: Level
    
    var body: some View {
        Form {
            Section(header: Text("Level Details"),
                    footer: Text("")) {
                        
                        TextFieldWithReset("Name", text: $draft.name)
                        TextFieldWithReset("Description", text: $draft.description)
                        Text(draft.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Stepper(value: $draft.conversionRate, in: 0...1, step: 0.001) {
                            HStack {
                                Text("Conversion Rate")
                                Spacer()
                                Text(draft.conversionRate.formattedPercentageWithMax5Decimal)
                                    .foregroundColor(.systemOrange)
                            }
                        }
                        .contextMenu {
                            ForEach([0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.005, 0.01, 0.05, 0.1], id: \.self) { item in
                                Button(action: {
                                    self.draft.conversionRate = item
                                }) {
                                    HStack {
                                        Text(item.formattedPercentageWithMax5Decimal)
                                        Image(systemName: "arrowshape.turn.up.left")
                                    }
                                }
                            }
                        }
            }
        }
    }
}

struct LevelEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LevelEditor(draft: .constant(sampleFunnels[0].levels[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

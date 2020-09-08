//
//  ListRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct TextTitle: View {
    var title: String
    var active = true
    
    var body: some View {
        Text(verbatim: title)
            .font(.headline)
            .foregroundColor(active ? .primary : .secondary)
    }
}

struct TextSubtitle: View {
    var subtitle: String
    var active = true
    
    var body: some View {
        Text(verbatim: subtitle)
            .font(.subheadline)
            //            .fontWeight(.light)
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
}

struct TextExtra: View {
    var extra: String = ""
    var active = true
    
    var body: some View {
        Text(extra)
            .fontWeight(.light)
            .font(.footnote)
            .foregroundColor(active ? .primary : .secondary)
        //            .lineLimit(1)
    }
}

struct TextDetail: View {
    var detail: String = ""
    var active = true
    
    var body: some View {
        Text(detail)
            //            .fontWeight(.light)
            .font(active ? .subheadline : .footnote)
    }
}

struct ListRow: View {
    var title: String
    var subtitle: String
    var extra: String = ""
    var detail: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                TextTitle(title: title)
                
                TextSubtitle(subtitle: subtitle)
                //                Text(verbatim: subtitle)
                //                    .font(.headline)
                //                    .fontWeight(.light)
                //                    .foregroundColor(.secondary)
                //                    .lineLimit(3)
                
                if extra.isNotEmpty {
                    TextExtra(extra: extra)
                }
                //                Text(extra)
                //                    .fontWeight(.light)
                //                    .font(.subheadline)
                //                    .lineLimit(1)
            }
            .layoutPriority(7)
            
            Spacer()
            
            TextDetail(detail: detail)
                //            Text(detail)
                //                .fontWeight(.light)
                .layoutPriority(9)
        }
    }
}

struct ListRow2: View {
    var title: String
    var subtitle: String
    var extra: String = ""
    var detail: String
    var active = true
    var full = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(verbatim: title)
                    .font(active ? .headline : .callout)
                    .foregroundColor(active ? .primary : .secondary)
                
                Spacer()
                
                Text(detail)
                    .font(active ? .subheadline : .footnote)
                    .foregroundColor(.systemOrange)
            }
            
            Text(verbatim: subtitle)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(full ? nil : 1)
            
            if extra.isNotEmpty {
                Text(extra)
                    .font(.footnote)
                    .foregroundColor(active ? .primary : .secondary)
            }
        }
        .contentShape(Rectangle())
    }
}

struct ListRow2a: View {
    var title: String
    var subtitle: String
    var extra: String = ""
    var detail: String
    var active = true
    var full = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(verbatim: title)
                    .font(active ? .headline : .callout)
                    .foregroundColor(active ? .systemOrange : .secondary)
                
                Spacer()
                
                Text(detail)
                    .font(active ? .subheadline : .footnote)
                    .foregroundColor(active ? .primary : .secondary)
            }
            
            Text(verbatim: subtitle)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(full ? nil : 1)
            
            if extra.isNotEmpty {
                Text(extra)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .contentShape(Rectangle())
    }
}

struct ListRow2b: View {
    var title: String
    var subtitle: String
    var extra: String = ""
    var detail: String
    var active = true
    var full = false
    var color = Color.systemTeal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(verbatim: title)
                    .font(active ? .headline : .callout)
                    .foregroundColor(active ? .systemOrange : .secondary)
                
                Spacer()
                
                Text(detail)
                    .font(active ? .callout : .subheadline)
                    .foregroundColor(active ? .primary : .secondary)
            }
            
            Text(verbatim: subtitle)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(full ? nil : 1)
            
            if extra.isNotEmpty {
                Text(extra)
                    .font(.footnote)
                    .foregroundColor(active ? color : .secondary)
            }
        }
        .contentShape(Rectangle())
    }
}

struct ListRow3: View {
    var title: String
    var subtitle: String
    var extra: String = ""
    var detail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                TextTitle(title: title)
                Spacer()
                TextDetail(detail: detail)
            }
            
            HStack {
                TextSubtitle(subtitle: subtitle)
                Spacer()
                TextExtra(extra: extra)
            }
        }
    }
}

#if DEBUG
struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                ListRow2(title: "ListRow2 default",
                         subtitle: "Some long long long long long long long long long long long long long long long long long long long long description goes here",
                         extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                         detail: "€ 65 790")
                
                ListRow2(title: "ListRow2 title (full subtitle)",
                         subtitle: "Some long long long long long long long long long long long long long long long long long long long long description goes here",
                         extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                         detail: "€ 65 790",
                         full: true)
                
                ListRow2(title: "ListRow2 inactive",
                         subtitle: "Some long long long long description goes here",
                         extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                         detail: "OFF",
                         active: false)
            }
            
            Group {
                Text("ListRow2a:").font(.headline)
                
                ListRow2a(title: "ListRow2a default",
                          subtitle: "Some long long long long description goes here",
                          extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                          detail: "€ 65 790")
                
                ListRow2a(title: "ListRow2a inactive",
                          subtitle: "Some long long long long description goes here",
                          extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                          detail: "OFF",
                          active: false)
                
                ListRow2(title: "ListRow2 title",
                         subtitle: "Some long long long long description goes here",
                         extra: "and some extra is here. could be pretty long enough",
                         detail: "OFF",
                         active: false)
                    .environment(\.sizeCategory, .extraExtraLarge)
            }
            
            Group {
                Text("ListRow2b:").font(.headline)
                
                ListRow2b(title: "ListRow2b default",
                          subtitle: "Some long long long long description goes here",
                          extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                          detail: "€ 65 790")
                
                ListRow2b(title: "ListRow2b inactive",
                          subtitle: "Some long long long long description goes here",
                          extra: "and some extra is here. could be pretty long long long long long long long long long long long long long long enough",
                          detail: "OFF",
                          active: false)
                
                ListRow2b(title: "ListRow2b extraExtraLarge",
                          subtitle: "Some long long long long description goes here",
                          extra: "and some extra is here. could be pretty long enough",
                          detail: "OFF",
                          active: false)
                    .environment(\.sizeCategory, .extraExtraLarge)
            }
            
            Group {
                Text("Other rows:").font(.headline)
                
                ListRow(title: "ListRow title",
                        subtitle: "Some long long long long description goes here",
                        extra: "and some extra is here. could be pretty long enough",
                        detail: "€ 62 523")
                
                ListRow(title: "ListRow title",
                        subtitle: "Some long long long long description goes here",
                        extra: "and some extra is here. could be pretty long enough",
                        detail: "€ 62 523")
                    .environment(\.sizeCategory, .extraExtraLarge)
                
                ListRow3(title: "ListRow3 title",
                         subtitle: "Short description  here",
                         extra: "some short extra",
                         detail: "€ 65 790")
                
                ListRow3(title: "ListRow3 title",
                         subtitle: "Short description  here",
                         extra: "some short extra",
                         detail: "€ 65 790")
                    .environment(\.sizeCategory, .extraExtraLarge)
            }
        }
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraLarge)
        .previewLayout(.fixed(width: 343, height: 1800))
    }
}
#endif

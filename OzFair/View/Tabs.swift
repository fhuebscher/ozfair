//
//  Tabs.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct Tabs: View {
    let items: [(String, CGFloat, Bool)]
    var body: some View {
        HStack(spacing: 25) {
            ForEach(items.indices) { index in
                let color = items[index].2 ? Color.navActive : Color.text
                let opacity: Double = items[index].2 ? 1 : 0
                VStack {
                    Text(items[index].0)
                        .fontWeight(.semibold)
                        .font(.caption)
                        .lineSpacing(20)
                        .foregroundColor(color)
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: items[index].1, height: 2)
                        .foregroundColor(color)
                        .opacity(opacity)
                }
            }
            Spacer()
        }
    }
}

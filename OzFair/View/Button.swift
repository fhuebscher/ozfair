//
//  Button.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    let label: String
    let icon: String?
    var padding: CGFloat = 10
    let action: () -> Void
    let fontSize: Font
    var color: Color = Color.navActive
    
    init(label: String, icon: String? = nil, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        padding = icon == nil ? 15 : 10
        self.action = action
        self.fontSize = .caption
    }
    
    init(label: String, color: Color, fontSize: Font? = nil, action: @escaping () -> Void) {
        self.label = label
        if let fontSize = fontSize {
            self.fontSize = fontSize
        } else {
            self.fontSize = .body
        }
        self.action = action
        self.icon = nil
        self.color = color
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.navActive)
                        .padding(.trailing, 5)
                    Text(label)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                } else {
                    Spacer()
                    Text(label)
                        .fontWeight(.semibold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .padding(padding)
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: .infinity)
    }
}

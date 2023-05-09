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
    var padding: CGFloat
    
    init(label: String, icon: String? = nil) {
        self.label = label
        self.icon = icon
        padding = icon == nil ? 15 : 10
    }
    
    var body: some View {
        Button(action: {
            // Action to perform when button is tapped
        }) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.navActive)
                        .padding(.trailing, 5)
                    Text(label)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.navActive)
                        .multilineTextAlignment(.center)
                } else {
                    Spacer()
                    Text(label)
                        .fontWeight(.semibold)
                        .foregroundColor(.navActive)
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

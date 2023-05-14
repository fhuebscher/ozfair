//
//  List.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct ListItem: View {
    let title: String
    let date: String
    let amount: Double
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter
    }()
    
    var formattedAmount: String {
        Self.formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                Image(systemName: "arrow.up.right")
                    .foregroundColor(.navActive)
            }
            .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.text)
                    .font(.callout)
                    .lineSpacing(24)
                
                Text(date)
                    .fontWeight(.semibold)
                    .foregroundColor(.fadedText)
                    .font(.caption)
                    .lineSpacing(20)
            }
            Spacer()
            Text(formattedAmount)
                .fontWeight(.semibold)
                .foregroundColor(.text)
                .font(.callout)
                .lineSpacing(24)
        }
        .padding(.top, 10)
        RoundedRectangle(cornerRadius: 1)
            .frame(width: .infinity, height: 1)
            .foregroundColor(.fadedText)
    }
}


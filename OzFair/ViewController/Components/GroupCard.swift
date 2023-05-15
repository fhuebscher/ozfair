//
//  GroupCard.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

// Group Card View - see Figma Prototype
struct GroupCard: View {
    let title: String
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
        VStack(alignment: .leading) {
            HStack {
                Text("\(title)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.text)
                Spacer()
                UserCircleStack()
            }
            
            Spacer()
            HStack {
                Text("Balance")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.text)
                Spacer()
                Text(formattedAmount)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.text)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
        .padding(25)
        .background(Color.groupCardColor)
        .cornerRadius(10)
    }
}

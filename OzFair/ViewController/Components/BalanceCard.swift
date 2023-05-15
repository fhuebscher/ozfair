//
//  Cards.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI


// Balance Card Component

struct BalanceCard: View, Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
    var amount: Double
    let bgColor: Color
    let from: String
    
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
            Text("\(title)")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 25)
                .padding(.leading, 30)
            Text(formattedAmount)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 25)
                .padding(.leading, 30)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 80, height: 150, alignment: .leading)
        .background(bgColor)
        .cornerRadius(10)
    }
}

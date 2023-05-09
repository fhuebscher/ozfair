//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Whole stack
        VStack(alignment: .leading) {
            // Title
            VStack(alignment:.leading) {
                Text("Accounts and Cards")
                .fontWeight(.semibold)
                .font(.caption)
                .foregroundColor(.subheading)
                .lineSpacing(20)
                Text("Welcome Fabian!")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .foregroundColor(.heading)
                .lineSpacing(38)

            }
            Spacer()
            // Tabs
            Tabs(items: [("Accounts", 58, true), ("Cards", 38, false)])
            Spacer()
            
            ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            Cards(title: "Spending 1", amount: 2000.05, bgColor: .cardColor1)
                            Cards(title: "Spending 2", amount: 100.23, bgColor: .cardColor2)
                            Cards(title: "Spending 3", amount: 24.50, bgColor: .cardColor2)
                            Cards(title: "Spending 4", amount: 1500.45, bgColor: .cardColor2)
                        }
                    }
            
            Spacer()
            Text("Recent Transactions")
            .fontWeight(.semibold)
            .font(.headline)
            .foregroundColor(.text)
            .lineSpacing(20)
            .padding(.bottom, 20)
            
            Tabs(items: [
                ("Today", 38, true),
                ("This Week", 2, false),
                ("This Month", 2, false),
                ("6 Months", 2, false),
            ])
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        // Whole Stack End
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

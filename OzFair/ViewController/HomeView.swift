//
//  HomeView.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var datastore = Datastore.shared
    @State var selection = 0
    
    
    var body: some View {
        
        // Whole stack
        ScrollView(.vertical, showsIndicators: true) {
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
                Spacer(minLength: 50)
                // Tabs
                Tabs(items: [("Accounts", 58, true), ("Cards", 38, false)])
                Spacer(minLength: 20)
                
                //Group Cards and pagination
                TabView(selection:$selection) {
                    ForEach(datastore.getAccounts().sorted(by: { $0.key < $1.key }), id: \.key) { id, account in
                        let color = account.currency == "AUD" ? Color.cardColor1 : Color.cardColor2
                        BalanceCard(title: account.title, amount: account.amount, bgColor: color, from: account.currency)
                    }
                }
                .onChange(of: selection) { newSelection in
                    datastore.currentAccount = newSelection
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 160) // Set height to a fixed value
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = .white
                    UIPageControl.appearance().pageIndicatorTintColor = .fadedText
                }
                .background(Color.clear)
                .id("TabView") // Add an ID to the TabView
                
                Spacer(minLength: 20)
                // Recent Transactions
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
                .padding(.bottom, 10)
                
                VStack {
                    ForEach(datastore.getTransactions(group: datastore.currentAccount).sorted(by: { $0.key < $1.key }), id: \.key) { id, transaction in
                        ListItem(title: transaction.title, date: transaction.date, amount: transaction.amount)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
        }
        // Whole Stack End
        .background(Color.frameBG)
    }
}

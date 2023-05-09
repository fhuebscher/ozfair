//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            TransferView()
                .tabItem {
                    Image(systemName: "arrow.right.arrow.left")
                    Text("Transfer")
                }
                .tag(1)
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Groups")
                }
                .tag(1)
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(1)
        }
    }
}

struct HomeView: View {
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
                ListItem(title: "To Magnus", date: "08 May 2023", amount: 59.00)
                ListItem(title: "To Magnus", date: "08 May 2023", amount: 59.00)
                ListItem(title: "To Magnus", date: "08 May 2023", amount: 59.00)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .background(Color.frameBG)
        // Whole Stack End
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TransferView: View {
    var body: some View {
        Text("Transfer")
    }
}

struct GroupsView: View {
    var body: some View {
        Text("Groups")
    }
}

struct MoreView: View {
    var body: some View {
        Text("More")
    }
}

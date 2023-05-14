//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    
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
                .tag(2)
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(3)
        }
        .accentColor(.navActive)
    }
}

struct HomeView: View {
    //Transactions list
    let transactions = [Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00),
                        Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00),
                        Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00),
                        Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00)]
        
    
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            BalanceCard(title: "Spending 1", amount: 2000.05, bgColor: .cardColor1)
                            BalanceCard(title: "Spending 2", amount: 100.23, bgColor: .cardColor2)
                            BalanceCard(title: "Spending 3", amount: 24.50, bgColor: .cardColor2)
                            BalanceCard(title: "Spending 4", amount: 1500.45, bgColor: .cardColor2)
                        }
                        .padding(20)
                    }
            .padding(-30)
            
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
                ForEach(transactions) { transaction in
                    ListItem(title: transaction.title, date: transaction.date, amount: transaction.amount)
                }
             //Spacer(minLength: 10)// set a minimum length for the Spacer
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .background(Color.frameBG)
        // Whole Stack End
        
    }
}

//Transactions
struct Transaction: Identifiable {
    var id = UUID()
    var title: String
    var date: String
    var amount: Double
}

struct TransferView: View {
    var body: some View {
        
        // Whole stack
        VStack(alignment: .leading) {
            // Title
            VStack(alignment:.leading) {
                Text("Send and receive money")
                    .fontWeight(.semibold)
                    .font(.caption)
                    .foregroundColor(.subheading)
                    .lineSpacing(20)
                Text("Transfer")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .foregroundColor(.heading)
                    .lineSpacing(38)
                
            }
            // Tabs
            Tabs(items: [("Send", 30, true), ("Request", 1, false)])
                .padding(.vertical, 20)
            GridItem(title: "Spending Account")
            GridItem(title: "To")
            GridItem(title: "Amount", leftIcon: "dollarsign.square", textInput: "AU$ 0")
            GridItem(title: "Today", leftIcon: "calendar")
            Spacer()
            CustomButton(label: "Transfer Money")
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .background(Color.frameBG)
    }
}

struct GroupsView: View {
    var body: some View {
        
        // Whole stack
        VStack(alignment: .leading) {
            // Title
            HStack {
                VStack(alignment:.leading) {
                    Text("Split payments")
                        .fontWeight(.semibold)
                        .font(.caption)
                        .foregroundColor(.subheading)
                        .lineSpacing(20)
                    Text("Groups")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(.heading)
                        .lineSpacing(38)
                    
                }
                Spacer()
                CustomButton(label: "Settle up", icon: "dollarsign.square")
            }
            
            TabView {
                GroupCard(title:"Fiji", amount: 232.00)
                GroupCard(title:"Fiji", amount: 232.00)
                GroupCard(title:"Fiji", amount: 232.00)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .text
                UIPageControl.appearance().pageIndicatorTintColor = .fadedText
            }
            .padding(.horizontal, 0)
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
    }
}

struct MoreView: View {
    var body: some View {
        Text("More")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

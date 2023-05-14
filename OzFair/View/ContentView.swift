//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: NavTabs = .home
    
    var body: some View {
        
        VStack {
            // Show different views based on the selected tab
            if selectedTab == .home {
                HomeView()
            } else if selectedTab == .groups {
                GroupsView()
            } else if selectedTab == .transfer {
                TransferView()
            } else if selectedTab == .more {
                MoreView()
            }
            // Display the custom tab bar
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}


struct HomeView: View {
    //Transactions list
    let transactions = [Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00),
                        Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00),
                        Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00)]
    
    
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
                Spacer(minLength: 50)
                
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
                
                Spacer(minLength: 50)
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

struct TransferView: View {
    @State var amount = ""
    
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
            GridItem(title: "Amount", leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: $amount)
            GridItem(title: "Today", leftIcon: "calendar")
            Spacer()
            CustomButton(label: "Transfer Money") {}
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .background(Color.frameBG)
    }
}

struct GroupsView: View {
    @State var showPanel = false
    @ObservedObject var datastore = Datastore.shared

    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
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
                    CustomButton(label: "Settle up", icon: "dollarsign.square") {}
                        .shadow(radius:3, x:2, y:2)
                }
                
                TabView {
                    ForEach(Datastore.shared.getGroups().sorted(by: { $0.key < $1.key }), id: \.key) { id, group in
                        GroupCard(title:group.name, amount: group.amount)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = .text
                    UIPageControl.appearance().pageIndicatorTintColor = .fadedText
                }
                .padding(.horizontal, 0)
                Spacer()
                // Recent Transactions
                Text("Recent Expenses")
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
                    ForEach(datastore.expenses.sorted(by: { $0.key < $1.key }), id: \.key) { id, expense in
                        ListItem(title: expense.title, date: expense.date, amount: expense.amount)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
            .background(Color.frameBG)
            
            CustomButton(label: "Add Expense", icon: "plus") {
                showPanel = true
                print("here")
            }
                .sheet(isPresented: $showPanel) {
                    NewExpensesPanel()
                }
                .padding(.trailing, 25)
                .padding(.bottom, 25)
                .shadow(radius:3, x:2, y:2)
        }
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

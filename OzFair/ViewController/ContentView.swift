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
                TransferView() // TransferView(transferViewModel = TransferViewModel())
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
                        Transaction(title: "To Fabian", date: "01 May 2023", amount: 123.40),
                        Transaction(title: "To Joel", date: "28 April 2023", amount: 21.60)]
    
    
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
                        ForEach(balances, id: \.self) { balance in
                            balance
                                .padding(20)
                        }
                    }
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
    @State var amount = "0.0"
    @State var convertedAmount = "0.0"
    @State var selectedAccount = 0
    @State var selectedCurrency = 0
    @State private var showingConfirmation = false
    
    private let transferService = TransferService()
    
    var amountFromTitle: String {
        let currencySign: String
        
        switch balances[selectedAccount].from {
        case "AUD":
            currencySign = "AU$"
        case "EUR":
            currencySign = "€"
        case "USD":
            currencySign = "$"
        default:
            currencySign = ""
        }
        
        return "From (in \(currencySign))"
    }
    
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
            HStack {
                Text("From: ")
                    .fontWeight(.semibold)
                    .foregroundColor(.fadedText)
                    .font(.callout)
                    .lineSpacing(24)
                    .padding(.trailing, 10)
                Spacer()
                Picker("Select Account", selection: $selectedAccount) {
                    ForEach(balances.indices, id: \.self) { index in
                        let balance = balances[index]
                        Text("\(balance.title) - $\(String(format: "%.2f", balance.amount))")
                    }
                }
                .accentColor(.primary)

            }
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .padding(.trailing, 5)
            .background(Color.white)
            .cornerRadius(10)
            .frame(width: .infinity, alignment: .center)
            HStack {
                Text("To: ")
                    .fontWeight(.semibold)
                    .foregroundColor(.fadedText)
                    .font(.callout)
                    .lineSpacing(24)
                    .padding(.trailing, 10)
                Spacer()
                Picker("Select Recipient", selection: $selectedCurrency) {
                    ForEach(accounts.indices, id: \.self) { index in
                        let account = accounts[index]
                        Text("\(account["name"]!) - \(account["currency"]!)")
                    }
                }
                .accentColor(.primary)
            }
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .padding(.trailing, 5)
            .background(Color.white)
            .cornerRadius(10)
            .frame(width: .infinity, alignment: .center)
            GridItem(title: amountFromTitle, leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: $amount)
            GridItem(title: "To  (in \(accounts.indices.contains($selectedCurrency.wrappedValue) ? accounts[$selectedCurrency.wrappedValue]["currency"] ?? "AU$" : ""))", leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: Binding(get: {
                let amountDouble = Double(amount) ?? -1.0
                let selectedCurrency = balances[$selectedAccount.wrappedValue].from
                let targetCurrency = accounts.indices.contains($selectedCurrency.wrappedValue) ? accounts[$selectedCurrency.wrappedValue]["to"] ?? "AUD" : "AUD"
                let convertedAmount = convertAmount(amount: amountDouble, from: selectedCurrency, to: targetCurrency)
                return String(format: "%.2f", convertedAmount)
            }, set: { newValue in
                convertedAmount = newValue
            }))

            GridItem(title: "Today", leftIcon: "calendar")
            CustomButton(label: "Transfer Money") {
                amount = "0.0"
                convertedAmount = "0.0"
                selectedAccount = 0
                selectedCurrency = 0
                showingConfirmation = true
                balances[$selectedAccount.wrappedValue].amount -= Double(amount) ?? 100.0
            }
                .padding(.bottom, 30)
                .alert(isPresented: $showingConfirmation) {
                    Alert(title: Text("Confirm Transfer"), message: Text("Are you sure you want to transfer the money?"), primaryButton: .destructive(Text("Transfer")) {
                            // perform the transfer action here
                        }, secondaryButton: .cancel())
                }
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .padding(.horizontal, 30)
        .background(Color.frameBG)
    }
    
  
}

var currentGroup: Int = 0

struct GroupsView: View {
    @State var showPanel = false
    @ObservedObject var datastore = Datastore.shared
    @State var selection = 0
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            ScrollView {
                VStack {
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
                    Spacer(minLength: 0)
                    
                    //Group Cards and pagination
                    TabView(selection:$selection) {
                        ForEach(datastore.getGroups().sorted(by: { $0.key < $1.key }), id: \.key) { id, group in
                            let expenses = datastore.getExpenses(group: id)
                            let total = expenses.values.reduce(0, { $0 + $1.amount })
                            GroupCard(title: group.name, amount: total).tag(id)
                        }
                        .padding(.horizontal, 20)
                    }
                    .onChange(of: selection) { newSelection in
                        datastore.currentGroup = newSelection
                    }
                    .padding(.horizontal, -20)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 300) // Set height to a fixed value
                    .onAppear {
                        UIPageControl.appearance().currentPageIndicatorTintColor = .text
                        UIPageControl.appearance().pageIndicatorTintColor = .fadedText
                    }
                    .background(Color.clear)
                    .id("TabView") // Add an ID to the TabView
                    // Recent Transactions

                    HStack{
                        Text("Recent Expenses")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .foregroundColor(.text)
                            .lineSpacing(20)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    
                    Tabs(items: [
                        ("Today", 38, true),
                        ("This Week", 2, false),
                        ("This Month", 2, false),
                        ("6 Months", 2, false),
                    ])
                    .padding(.bottom, 10)
                    
                    //Expenses
                    ScrollViewReader { scrollViewProxy in // Wrap the VStack inside a ScrollViewReader
                        VStack {
                            ForEach(datastore.getExpenses(group: datastore.currentGroup).sorted(by: { $0.key < $1.key }), id: \.key) { id, expense in
                                ListItem(title: expense.title, date: expense.date, amount: expense.amount)
                            }
                        }
                        .id("List") // Add an ID to the VStack
                        .onAppear {
                            // Scroll to the bottom of the list when it first appears
                            withAnimation {
                                scrollViewProxy.scrollTo("List", anchor: .bottom)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                
            }
            HStack {
                Spacer()
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
        .background(Color.frameBG)
    }
}



struct MoreView: View {
    var body: some View {
        Spacer()
        Text("More")
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

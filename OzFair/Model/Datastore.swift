//
//  Datastore.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

// TODO probably not used

import Foundation
import Combine

class Datastore: ObservableObject {
    static let shared = Datastore()
    
    private let accountsUrl: URL
    private let transactionsUrl: URL
    private let groupsUrl: URL
    private let expenseUrl: URL
    
    @Published var accounts: [Int: Account] = [:]
    @Published var transactions: [Int: Transaction] = [:]
    @Published var groups: [Int: GroupStruct] = [:]
    @Published var expenses: [Int: Expense] = [:]
    @Published var currentAccount: Int = 0
    @Published var currentGroup: Int = 0
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.accountsUrl = documentsDirectory.appendingPathComponent("accounts.plist")
        self.transactionsUrl = documentsDirectory.appendingPathComponent("transaction.plist")
        self.groupsUrl = documentsDirectory.appendingPathComponent("groups.plist")
        self.expenseUrl = documentsDirectory.appendingPathComponent("expense.plist")
        
        if let accounts = NSDictionary(contentsOf: accountsUrl) as? [Int: Account] {
            self.accounts = accounts
        } else {
            self.accounts = [
                0: Account(title: "Spending 1 AUD", amount: 259.50, currency: "AUD"),
                1: Account(title: "Spending 2 USD", amount: 400.25, currency: "USD"),
                2: Account(title: "Saving 1 USD", amount: 2250.00, currency: "USD"),
            ]
            let dict = NSDictionary(dictionary: self.accounts)
            dict.write(to: accountsUrl, atomically: true)
        }
        
        if let transactions = NSDictionary(contentsOf: transactionsUrl) as? [Int: Transaction] {
            self.transactions = transactions
        } else {
            self.transactions = [
                0: Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00, belongsTo: 0),
                1: Transaction(title: "To Fabian", date: "01 May 2023", amount: 123.40, belongsTo: 1),
                2: Transaction(title: "To Joel", date: "28 April 2023", amount: 21.60, belongsTo: 2)
            ]
            let dict = NSDictionary(dictionary: self.transactions)
            dict.write(to: transactionsUrl, atomically: true)
        }
        
        if let groups = NSDictionary(contentsOf: groupsUrl) as? [Int: GroupStruct] {
            self.groups = groups
        } else {
            self.groups = [
                0: GroupStruct(name:"Birthday Trip", currency: 0),
                1: GroupStruct(name:"Fiji", currency: 0),
                2: GroupStruct(name:"Japan Trip", currency: 0),
            ]
            let dict = NSDictionary(dictionary: self.groups)
            dict.write(to: groupsUrl, atomically: true)
        }
        
        if let expenses = NSDictionary(contentsOf: expenseUrl) as? [Int: Expense] {
            self.expenses = expenses
        } else {
            self.expenses = [
                0: Expense(title:"Dinner", amount: 160.50, date: "12 May 2023", belongsTo: 1),
                1: Expense(title:"Groceries", amount: 25.45, date: "11 May 2023", belongsTo: 1),
                2: Expense(title:"Cinema", amount: 65.30, date: "05 May 2023", belongsTo: 2),
                3: Expense(title:"Booze", amount: 180.50, date: "03 May 2023", belongsTo: 0),
                4: Expense(title:"Ziplining", amount: 300.00, date: "02 May 2023", belongsTo: 2),
                5: Expense(title:"Cake", amount: 42.15, date: "28 April 2023", belongsTo: 0),
                6: Expense(title:"Fairy", amount: 420.60, date: "27 April 2023", belongsTo: 1),
                7: Expense(title:"Resort", amount: 1249.23, date: "25 April 2023", belongsTo: 1),
                8: Expense(title:"Sushi", amount: 120.00, date: "01 May 2023", belongsTo: 2),
            ]
            let dict = NSDictionary(dictionary: self.expenses)
            dict.write(to: expenseUrl, atomically: true)
        }
    }
    
    func getAccounts() -> [Int: Account] {
        return accounts
    }
    
    func getAccount(id: Int) -> Account {
        if let account = accounts[id] {
            return account
        } else {
            return Account(title: "Default", amount: 0, currency: "AUD")
        }
    }
    
    func setAccountAmount(id: Int, amount: Double) {
        if let account = accounts[id] {
            let newAmount = account.amount - amount
            let newAccount = Account(title: account.title, amount: newAmount, currency: account.currency)
            accounts[id] = newAccount
            let dict = NSDictionary(dictionary: accounts)
            dict.write(to: accountsUrl, atomically: true)
        }
    }
    
    func getTransactions(group: Int = -1) -> [Int: Transaction] {
        print(transactions)
        if group == -1 {
            return transactions
        } else {
            print(transactions.filter({ $0.value.belongsTo == group }))
            print(group)
            return transactions.filter({ $0.value.belongsTo == group })
        }
    }
    
    func getGroups() -> [Int: GroupStruct] {
        return groups
    }
    
    func getCurrentGroup() -> GroupStruct {
        if let group = groups[currentGroup] {
            return group
        } else {
            return GroupStruct(name: "Default", currency: 0)
        }
    }
    
    func getExpenses(group: Int = -1) -> [Int: Expense] {
        if group == -1 {
            return expenses
        } else {
            return expenses.filter({ $0.value.belongsTo == group })
        }
    }
    
    func setExpense(expense: Expense, id: Int = -1) {
        let idComp = id == -1 ? expenses.count : id
        expenses[idComp] = expense
        let dict = NSDictionary(dictionary: expenses)
        dict.write(to: expenseUrl, atomically: true)
    }
}

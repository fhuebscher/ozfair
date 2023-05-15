//
//  Datastore.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

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
            self.accounts = accountsMock
            let dict = NSDictionary(dictionary: self.accounts)
            dict.write(to: accountsUrl, atomically: true)
        }
        
        if let transactions = NSDictionary(contentsOf: transactionsUrl) as? [Int: Transaction] {
            self.transactions = transactions
        } else {
            self.transactions = transactionsMock
            let dict = NSDictionary(dictionary: self.transactions)
            dict.write(to: transactionsUrl, atomically: true)
        }
        
        if let groups = NSDictionary(contentsOf: groupsUrl) as? [Int: GroupStruct] {
            self.groups = groups
        } else {
            self.groups = groupsMock
            let dict = NSDictionary(dictionary: self.groups)
            dict.write(to: groupsUrl, atomically: true)
        }
        
        if let expenses = NSDictionary(contentsOf: expenseUrl) as? [Int: Expense] {
            self.expenses = expenses
        } else {
            self.expenses = expensesMock
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

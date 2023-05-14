//
//  Datastore.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

// TODO probably not used

import Foundation

// Singleton Datastore that gets and sets scores and settings
class Datastore {
    static let shared = Datastore()
    
    private let balanceUrl: URL
    private let friendsUrl: URL
    private let groupsUrl: URL
    private let expenseUrl: URL
    var balance: [String: Int] = [:]
    var friends: [String: String] = [:]
    var groups: [Int: GroupStruct] = [:]
    var expenses: [Int: Expense] = [:]
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.balanceUrl = documentsDirectory.appendingPathComponent("balance.plist")
        self.friendsUrl = documentsDirectory.appendingPathComponent("friends.plist")
        self.groupsUrl = documentsDirectory.appendingPathComponent("groups.plist")
        self.expenseUrl = documentsDirectory.appendingPathComponent("expense.plist")
        
        if let balance = NSDictionary(contentsOf: balanceUrl) as? [String: Int] {
            self.balance = balance
        }
        
        if let friends = NSDictionary(contentsOf: friendsUrl) as? [String: String] {
            self.friends = friends
        }
        
        if let groups = NSDictionary(contentsOf: groupsUrl) as? [Int: GroupStruct] {
            print("here")
            self.groups = groups
        } else {
            self.groups = [
                0: GroupStruct(name:"Fiji", amount: 1800.25, currency: 0),
                1: GroupStruct(name:"Birthday Trip", amount: 765.23, currency: 0),
                2: GroupStruct(name:"Japan Trip", amount: -1200.75, currency: 0),
            ]
            let dict = NSDictionary(dictionary: self.groups)
            dict.write(to: groupsUrl, atomically: true)
        }
        
        if let expenses = NSDictionary(contentsOf: expenseUrl) as? [Int: Expense] {
            self.expenses = expenses
        }
    }
    
    func getBalance() -> [String: Int] {
        return balance
    }
    
    func setBalance(account: String, number: Int) {
        balance[account] = number
        let dict = NSDictionary(dictionary: balance)
        dict.write(to: balanceUrl, atomically: true)
    }
    
    func getFriends() -> [String: String] {
        return friends
    }
    
    func getGroups() -> [Int: GroupStruct] {
        return groups
    }
    
    func getExpenses() -> [Int: Expense] {
        return expenses
    }
    
    func setExpense(expense: Expense, id: Int = -1) {
        let idComp = id == -1 ? expenses.count : id
        expenses[idComp] = expense
        let dict = NSDictionary(dictionary: expenses)
        print(expenses)
        dict.write(to: expenseUrl, atomically: true)
    }
}

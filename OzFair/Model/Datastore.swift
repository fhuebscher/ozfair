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
    
    private let balanceUrl: URL
    private let friendsUrl: URL
    private let groupsUrl: URL
    private let expenseUrl: URL
    
    @Published var balance: [String: Int] = [:]
    @Published var friends: [String: String] = [:]
    @Published var groups: [Int: GroupStruct] = [:]
    @Published var expenses: [Int: Expense] = [:]
    @Published var currentGroup: Int = 0
    
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
            let dict = NSDictionary(dictionary: self.groups)
            dict.write(to: groupsUrl, atomically: true)
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
        print(expenses)
        dict.write(to: expenseUrl, atomically: true)
    }
}

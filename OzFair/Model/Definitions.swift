//
//  Definitions.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation

// All the different types of data (groups, accounts, transactions, and expenses)

struct GroupStruct {
    let name: String
    let currency: Int // for different currencies
}

struct Account {
    let title: String
    var amount: Double
    let currency: String
}

struct Transaction {
    let title: String
    let date: String
    let amount: Double
    let belongsTo: Int
}

struct Expense {
    let title: String
    let amount: Double
    let date: String
    let belongsTo: Int
    
    init(title: String, amount: Double, date: String, belongsTo: Int) {
        self.title = title
        self.amount = amount
        self.date = date
        self.belongsTo = belongsTo
    }
}

// Currencies and their sign
enum Currency: String {
    case AUD
    case EUR
    case USD
    
    func getSign() -> String {
        switch self {
        case .AUD:
            return "A$"
        case .EUR:
            return "€"
        case .USD:
            return "$"
        }
    }
}

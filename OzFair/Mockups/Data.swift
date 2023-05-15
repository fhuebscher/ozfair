//
//  Data.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation

let accountsMock = [
    0: Account(title: "Spending 1 AUD", amount: 259.50, currency: "AUD"),
    1: Account(title: "Spending 2 USD", amount: 400.25, currency: "USD"),
    2: Account(title: "Saving 1 USD", amount: 2250.00, currency: "USD"),
]

let transactionsMock = [
    0: Transaction(title: "To Magnus", date: "08 May 2023", amount: 59.00, belongsTo: 0),
    1: Transaction(title: "To Fabian", date: "01 May 2023", amount: 123.40, belongsTo: 1),
    2: Transaction(title: "To Joel", date: "28 April 2023", amount: 21.60, belongsTo: 2)
]

let groupsMock = [
    0: GroupStruct(name:"Birthday Trip", currency: 0),
    1: GroupStruct(name:"Fiji", currency: 0),
    2: GroupStruct(name:"Japan Trip", currency: 0),
]

let expensesMock = [
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

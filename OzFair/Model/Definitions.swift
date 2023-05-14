//
//  Definitions.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation

struct GroupStruct {
    let name: String
    let amount: Double
    let currency: Int
}


struct Transaction: Identifiable {
    var id = UUID()
    var title: String
    var date: String
    var amount: Double
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

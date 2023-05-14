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
    let id = UUID()
    let title: String
    let amount: Double
    let date: String
}

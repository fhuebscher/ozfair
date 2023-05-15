//
//  TransferViewModel.swift
//  OzFair
//
//  Created by Florian Huebscher on 13.05.23.
//

import Foundation

// Alternative to Datastore for the TransferView
class TransferViewModel: ObservableObject {
    @Published var amount: String = "0.0"
    @Published var sourceCurrency: String = "EUR" {
        didSet {
            updateConvertedAmount()
        }
    }
    @Published var targetCurrency: String = "AUD"
    @Published var convertedAmount: String = "0.0"
    private let transferService = TransferService()
    
    func updateConvertedAmount() {
        if let amountDouble = Double(amount),
           let convertedAmountDouble = transferService.convert(amountDouble, from: sourceCurrency, to: targetCurrency) {
            convertedAmount = String(format: "%.2f", convertedAmountDouble)
        } else {
            convertedAmount = ""
        }
    }
}

//
//  TransferView.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation
import SwiftUI

struct TransferView: View {
    @State var amount = "0.0"
    @State var convertedAmount = "0.0"
    @State var selectedAccount = 0
    @State var selectedCurrency = 0
    @State private var showingConfirmation = false
    @ObservedObject var datastore = Datastore.shared
    
    private let transferService = TransferService()
    
    var amountFromTitle: String {
        let currencySign: String
        // Retrieve accounts from datastore
        let accounts = datastore.getAccounts()
        if let account = accounts[selectedAccount] {
            // currency mapping to currency sign
            switch account.currency {
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
        } else {
            return "From"
        }
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
                    ForEach(datastore.getAccounts().sorted(by: { $0.key < $1.key }), id: \.key) { id, account in
                        Text("\(account.title) - $\(String(format: "%.2f", account.amount))")
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
                    ForEach(currencyMappings.indices, id: \.self) { index in
                        let account = currencyMappings[index]
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
            let currentAccount = datastore.getAccount(id: $selectedAccount.wrappedValue)
            GridItem(title: amountFromTitle, leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: Binding(
                get: {
                    return amount
                },
                set: { newValue in
                    nonNegativeNumber(text: &amount, newValue: newValue)
                    limitDecimalDigits(text: &amount, maxDigits: 2)
                }
            ))
            GridItem(title: "To  (in \(currencyMappings.indices.contains($selectedCurrency.wrappedValue) ? currencyMappings[$selectedCurrency.wrappedValue]["currency"] ?? "AU$" : ""))", leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: Binding(get: {
                let amountDouble = Double(amount) ?? -1.0
                let selectedCurrency = currentAccount.currency
                let targetCurrency = currencyMappings.indices.contains($selectedCurrency.wrappedValue) ? currencyMappings[$selectedCurrency.wrappedValue]["to"] ?? "AUD" : "AUD"
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
                datastore.setAccountAmount(id: $selectedAccount.wrappedValue, amount: Double(amount) ?? 0.00)
                // ToDo change this to real transfer in alert below
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

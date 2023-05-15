//
//  NewExpense.swift
//  OzFair
//
//  Created by Joel Weber on 14.05.23.
//

import Foundation
import SwiftUI

// Structure for New Exapneses Panel

struct NewExpensesPanel: View {
    @Environment(\.presentationMode) var presentationMode
    // Initalise state variables title and amount
    @State var title = ""
    @State var amount = ""
    @ObservedObject var datastore = Datastore.shared
        
    var body: some View {
        ZStack {
            Color.overlayCard
                .ignoresSafeArea()
            
            VStack {
                Button {
                  presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.fadedText)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
            }
                    
            VStack {
                // Grid items setup
                GridItem(title: "Title", leftTextInput: true, leftTextValue: $title)
                GridItem(title: "Amount", leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: Binding(
                    get: {
                        return amount
                    },
                    set: { newValue in
                        nonNegativeNumber(text: &amount, newValue: newValue)
                        limitDecimalDigits(text: &amount, maxDigits: 2)
                    }
                ))

                GridItem(title: "For", rightText: "All")
                
                HStack {
                    CustomButton(label: "Cancel Expense", color: .negativeAmount) {
                        presentationMode.wrappedValue.dismiss()
                    }
                        .padding(.trailing, 5)
                    Spacer()
                    CustomButton(label: "Confirm Expense", color: .navActive) {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        let todayString = dateFormatter.string(from: Date())
                        // Check for valid data type -> perform default action if not valid
                        if let amount = Double(amount) {
                            let exp = Expense(title: title, amount: Double(amount), date: todayString, belongsTo: datastore.currentGroup)
                            Datastore.shared.setExpense(expense: exp)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            amount = ""
                        }
                    }
                        .padding(.leading, 5)
                        .opacity(title != "" && amount != "" ? 1 : 0.5)
                }.padding(.top, 30)
                
                Spacer()
            }
            // horizontal and vertical padding
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
        }
    }
}


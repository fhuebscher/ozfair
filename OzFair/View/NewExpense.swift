//
//  NewExpense.swift
//  OzFair
//
//  Created by Joel Weber on 14.05.23.
//

import Foundation
import SwiftUI

struct NewExpensesPanel: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var amount = ""
        
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
                GridItem(title: "Title", leftTextInput: true, leftTextValue: $title)
                GridItem(title: "Amount", leftIcon: "dollarsign.square", textInput: "AU$ 0", rightTextValue: $amount)
                GridItem(title: "For", rightText: "All")
                
                HStack {
                    CustomButton(label: "Cancel Expense", color: .negativeAmount) {}
                        .padding(.trailing, 5)
                    Spacer()
                    CustomButton(label: "Confirm Expense", color: .navActive) {}
                        .padding(.leading, 5)
                }.padding(.top, 30)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
        }
    }
}


//
//  MoneyInput.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct MoneyInput: View {
    @Binding var value: String
    let text: String
    
    var body: some View {
        TextField(text, text: $value)
            .keyboardType(.decimalPad)
            .frame(width: 120)
            .multilineTextAlignment(.trailing)
            .background(Color.clear)
            .foregroundColor(.primary)
    }
}

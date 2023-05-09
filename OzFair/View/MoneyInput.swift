//
//  MoneyInput.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct MoneyInput: View {
    @State private var text = ""
    
    var body: some View {
        TextField("$0.00", text: $text)
            .keyboardType(.decimalPad)
            .frame(width: 120)
            .multilineTextAlignment(.trailing)
            .background(Color.clear)
            .foregroundColor(.primary)
    }
}

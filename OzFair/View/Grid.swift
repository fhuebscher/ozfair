//
//  Grid.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct GridItem: View {
    @State private var text = ""
    
    let title: String
    let leftIcon: String?
    let textInput: String?
    var initFunction = 0;
    
    init(title: String, leftIcon: String? = nil) {
        self.title = title
        self.leftIcon = leftIcon
        self.textInput = nil
    }
    
    init(title: String, leftIcon: String, textInput: String) {
        self.title = title
        self.leftIcon = leftIcon
        self.textInput = textInput
        initFunction = 1
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let leftIcon = leftIcon {
                Image(systemName: leftIcon)
                    .foregroundColor(.fadedText)
                    .padding(.trailing, 5)
            }
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.fadedText)
                .font(.callout)
                .lineSpacing(24)
                .padding(.trailing, 10)
            Spacer()
            if initFunction == 0 {
                Image(systemName: "chevron.right")
                    .foregroundColor(.fadedText)
                    .padding(.leading, 10)
            } else if textInput != nil {
                MoneyInput()
            }
        }
        .padding(.all, 20)
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: .infinity, alignment: .center)
    }
}

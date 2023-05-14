//
//  Grid.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct GridItem: View {
    @Binding var leftTextValue: String
    @Binding var rightTextValue: String
    
    let title: String
    let leftIcon: String?
    let textInput: String?
    var initFunction = 0
    var rightText = ""
    var leftTextInput = false
    
    init(title: String, leftIcon: String? = nil) {
        self.title = title
        self.leftIcon = leftIcon
        self.textInput = nil
        self._leftTextValue = Binding.constant("")
        self._rightTextValue = Binding.constant("")
    }
    
    init(title: String, rightText: String) {
        self.title = title
        self.leftIcon = nil
        self.textInput = nil
        self.rightText = rightText
        self._leftTextValue = Binding.constant("")
        self._rightTextValue = Binding.constant("")
    }
    
    init(title: String, leftTextInput: Bool, leftTextValue: Binding<String>) {
        self.title = title
        self.leftIcon = nil
        self.textInput = nil
        self.leftTextInput = leftTextInput
        self._leftTextValue = leftTextValue
        self._rightTextValue = Binding.constant("")
    }
    
    init(title: String, leftIcon: String, textInput: String, rightTextValue: Binding<String>) {
        self.title = title
        self.leftIcon = leftIcon
        self.textInput = textInput
        initFunction = 1
        self._leftTextValue = Binding.constant("")
        self._rightTextValue = rightTextValue
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let leftIcon = leftIcon {
                Image(systemName: leftIcon)
                    .foregroundColor(.fadedText)
                    .padding(.trailing, 5)
            }
            if leftTextInput {
                TextField(title, text: $leftTextValue)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .background(Color.clear)
                    .foregroundColor(.primary)
            } else {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.fadedText)
                    .font(.callout)
                    .lineSpacing(24)
                    .padding(.trailing, 10)
            }
            Spacer()
            if initFunction == 0 {
                if rightText != "" {
                    Text(rightText)
                        .fontWeight(.semibold)
                        .foregroundColor(.fadedText)
                        .font(.callout)
                        .lineSpacing(24)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.fadedText)
                    .padding(.leading, 10)
            } else if textInput != nil {
                MoneyInput(value: $rightTextValue, text: "$0.00")
            }
        }
        .padding(.all, 20)
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: .infinity, alignment: .center)
    }
}

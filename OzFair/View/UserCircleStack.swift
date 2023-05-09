//
//  UserCircleStack.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

import Foundation
import SwiftUI

struct UserCircleStack: View {
    let users: [String] = ["user1", "user2", "user3", "user4", "user5"]
    let circleSize: CGFloat = 40
    let overlapPercentage: CGFloat = 0.3
    
    var body: some View {
        ZStack(alignment: .center) {
            ForEach(0..<users.count, id: \.self) { index in
                let xOffset = CGFloat(index) * circleSize * (1 - overlapPercentage) - overlapPercentage * circleSize
                Circle()
                    .foregroundColor(Color.blue)
                    .opacity(1.0-0.2*Double(index))
                    .frame(width: circleSize, height: circleSize)
                    .overlay(
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(10)
                    )
                    .offset(x: xOffset, y: 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


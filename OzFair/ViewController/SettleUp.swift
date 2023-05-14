//
//  SettleUp.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation
import SwiftUI

struct SettleUpPanel: View {
    @Environment(\.presentationMode) var presentationMode
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
                VStack(alignment:.leading) {
                    Text(datastore.getCurrentGroup().name)
                        .fontWeight(.semibold)
                        .font(.caption)
                        .foregroundColor(.subheading)
                        .lineSpacing(20)
                    Text("Settle Up")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(.heading)
                        .lineSpacing(38)
                    
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
        }
    }
}


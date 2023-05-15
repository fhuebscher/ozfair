//
//  SettleUp.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation
import SwiftUI

// Structure for SettleUp Panel
struct SettleUpPanel: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var datastore = Datastore.shared
    
    var body: some View {
        ZStack {
            // Background color for the panel
            Color.overlayCard
                .ignoresSafeArea()
            
            VStack {
                // Close button
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.fadedText)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer() // Spacer to push content to the top
                
            }
            
            VStack {
                VStack(alignment:.leading) {
                    // Group name
                    Text(datastore.getCurrentGroup().name)
                        .fontWeight(.semibold)
                        .font(.caption)
                        .foregroundColor(.subheading)
                        .lineSpacing(20)
                    
                    // Title
                    Text("Settle Up")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(.heading)
                        .lineSpacing(38)
                }
                Spacer() // Spacer to push content to the top
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
        }
    }
}


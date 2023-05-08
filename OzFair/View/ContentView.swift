//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Group {
                Text("Accounts and Cards")
                .fontWeight(.semibold)
                .font(.caption)
                .lineSpacing(20)
                Text("Welcome Fabian!")
                .fontWeight(.semibold)
                .font(.title)
                .lineSpacing(38)

            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

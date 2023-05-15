//
//  ContentView.swift
//  OzFair
//
//  Created by Joel Weber on 08.05.23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: NavTabs = .home
    
    var body: some View {
        VStack {
            // Show different views based on the selected tab
            if selectedTab == .home {
                HomeView()
            } else if selectedTab == .groups {
                GroupsView()
            } else if selectedTab == .transfer {
                TransferView()
            } else if selectedTab == .more {
                MoreView()
            }
            // Display the custom tab bar
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

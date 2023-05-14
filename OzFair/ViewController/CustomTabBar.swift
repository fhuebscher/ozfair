//
//  CustomTabBar.swift
//  OzFair
//
//  Created by Magnus Heilesen Andersen on 14/5/2023.
//

import SwiftUI

enum NavTabs: Int {
    case home = 0
    case transfer = 1
    case groups = 2
    case more = 3
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: NavTabs
    
    
    var body: some View {

        HStack (spacing: 0){
            Spacer(minLength: 30)
            Button {
                selectedTab = .home
            } label: {
                
                VStack (alignment: .center, spacing: 10){
                    if selectedTab == .home {
                        Image("home-active")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else {
                        Image("home")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
        
                    Text("Home")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(selectedTab == .home ? Color.navActive : Color.navInactive)
                }
                
            }
            Spacer()
            Button {
                selectedTab = .transfer
            } label: {
                
                VStack (alignment: .center, spacing: 10){
                    if selectedTab == .transfer {
                        Image("transfer-active")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else {
                        Image("transfer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    Text("Transfer")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(selectedTab == .transfer ? Color.navActive : Color.navInactive)
                }
                
            }
            Spacer()
            Button {
                selectedTab = .groups
            } label: {
                
                VStack (alignment: .center, spacing: 10){
                    if selectedTab == .groups {
                        Image("groups-active")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else {
                        Image("groups")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    Text("Groups")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(selectedTab == .groups ? Color.navActive : Color.navInactive)
                }
                
            }
            Spacer()
            Button {
                selectedTab = .more
            } label: {
                
                VStack (alignment: .center, spacing: 10){
                    if selectedTab == .more {
                        Image("more-active")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else {
                        Image("more")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    Text("More")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(selectedTab == .more ? Color.navActive : Color.navInactive)
                }
                
            }
            Spacer(minLength: 30)
        }
        .frame(height: 80)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 4)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}

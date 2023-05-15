//
//  GroupsView.swift
//  OzFair
//
//  Created by Joel Weber on 15.05.23.
//

import Foundation
import SwiftUI

struct GroupsView: View {
    @State var showPanel = false
    @ObservedObject var datastore = Datastore.shared
    @State var selection = 0
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Split payments")
                                .fontWeight(.semibold)
                                .font(.caption)
                                .foregroundColor(.subheading)
                                .lineSpacing(20)
                            Text("Groups")
                                .fontWeight(.semibold)
                                .font(.largeTitle)
                                .foregroundColor(.heading)
                                .lineSpacing(38)
                            
                        }
                        Spacer()
                        CustomButton(label: "Settle up", icon: "dollarsign.square") {}
                            .shadow(radius:3, x:2, y:2)
                    }
                    Spacer(minLength: 0)
                    
                    //Group Cards and pagination
                    TabView(selection:$selection) {
                        ForEach(datastore.getGroups().sorted(by: { $0.key < $1.key }), id: \.key) { id, group in
                            let expenses = datastore.getExpenses(group: id)
                            let total = expenses.values.reduce(0, { $0 + $1.amount })
                            GroupCard(title: group.name, amount: total).tag(id)
                        }
                        .padding(.horizontal, 20)
                    }
                    .onChange(of: selection) { newSelection in
                        datastore.currentGroup = newSelection
                    }
                    .padding(.horizontal, -20)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 300) // Set height to a fixed value
                    .onAppear {
                        UIPageControl.appearance().currentPageIndicatorTintColor = .text
                        UIPageControl.appearance().pageIndicatorTintColor = .fadedText
                    }
                    .background(Color.clear)
                    .id("TabView") // Add an ID to the TabView
                    // Recent Transactions

                    HStack{
                        Text("Recent Expenses")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .foregroundColor(.text)
                            .lineSpacing(20)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    
                    Tabs(items: [
                        ("Today", 38, true),
                        ("This Week", 2, false),
                        ("This Month", 2, false),
                        ("6 Months", 2, false),
                    ])
                    .padding(.bottom, 10)
                    
                    //Expenses
                    ScrollViewReader { scrollViewProxy in // Wrap the VStack inside a ScrollViewReader
                        VStack {
                            ForEach(datastore.getExpenses(group: datastore.currentGroup).sorted(by: { $0.key < $1.key }), id: \.key) { id, expense in
                                ListItem(title: expense.title, date: expense.date, amount: expense.amount)
                            }
                        }
                        .id("List") // Add an ID to the VStack
                        .onAppear {
                            // Scroll to the bottom of the list when it first appears
                            withAnimation {
                                scrollViewProxy.scrollTo("List", anchor: .bottom)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                
            }
            HStack {
                Spacer()
                CustomButton(label: "Add Expense", icon: "plus") {
                    showPanel = true
                }
                .sheet(isPresented: $showPanel) {
                    NewExpensesPanel()
                }
                .padding(.trailing, 25)
                .padding(.bottom, 25)
                .shadow(radius:3, x:2, y:2)

            }
        }
        .background(Color.frameBG)
    }
}

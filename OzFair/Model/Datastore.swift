//
//  Datastore.swift
//  OzFair
//
//  Created by Joel Weber on 09.05.23.
//

// TODO probably not used

import Foundation

// Singleton Datastore that gets and sets scores and settings
class Datastore {
    static let shared = Datastore()
    
    private let balanceUrl: URL
    private let friendsUrl: URL
    private let groupsUrl: URL
    var balance: [String: Int] = [:]
    var friends: [String: String] = [:]
    var groups: [Int: GroupStruct] = [:]
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.balanceUrl = documentsDirectory.appendingPathComponent("balance.plist")
        self.friendsUrl = documentsDirectory.appendingPathComponent("friends.plist")
        self.groupsUrl = documentsDirectory.appendingPathComponent("groups.plist")
        
        if let balance = NSDictionary(contentsOf: balanceUrl) as? [String: Int] {
            self.balance = balance
        }
        
        if let friends = NSDictionary(contentsOf: friendsUrl) as? [String: String] {
            self.friends = friends
        }
        
        if var groups = NSDictionary(contentsOf: groupsUrl) as? [Int: GroupStruct] {
            print("here")
            self.groups = groups
        } else {
            self.groups = [
                0: GroupStruct(name:"Fiji", amount: 1800.25, currency: 0),
                1: GroupStruct(name:"Birthday Trip", amount: 765.23, currency: 0),
                2: GroupStruct(name:"Japan Trip", amount: -1200.75, currency: 0),
            ]
            let dict = NSDictionary(dictionary: self.groups)
            dict.write(to: groupsUrl, atomically: true)
        }
    }
    
    func getBalance() -> [String: Int] {
        return balance
    }
    
    func setBalance(account: String, number: Int) {
        balance[account] = number
        let dict = NSDictionary(dictionary: balance)
        dict.write(to: balanceUrl, atomically: true)
    }
    
    func getFriends() -> [String: String] {
        return friends
    }
    
    func getGroups() -> [Int: GroupStruct] {
        return groups
    }
}

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
    var balance: [String: Int] = [:]
    var friends: [String: String] = [:]
    
    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.balanceUrl = documentsDirectory.appendingPathComponent("balance.plist")
        self.friendsUrl = documentsDirectory.appendingPathComponent("friends.plist")
        
        if let balance = NSDictionary(contentsOf: balanceUrl) as? [String: Int] {
            self.balance = balance
        }
        
        if let friends = NSDictionary(contentsOf: friendsUrl) as? [String: String] {
            self.friends = friends
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
}

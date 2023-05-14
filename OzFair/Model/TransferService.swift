//
//  TransferService.swift
//  OzFair
//
//  Created by Florian Huebscher on 10.05.23.
//

import Foundation


// // Mock class for testing

//class TransferService {
//    func convert(_ amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double? {
//        guard let sourceRate = getRate(for: sourceCurrency), let targetRate = getRate(for: targetCurrency) else {
//            return nil
//        }
//        return amount * targetRate / sourceRate
//    }
//
//    private func getRate(for currency: String) -> Double? {
//        switch currency {
//        case "AUD":
//            return 1.0
//        case "EUR":
//            return 0.65
//        case "USD":
//            return 0.78
//        default:
//            return nil
//        }
//    }
//}

var balances = [
    BalanceCard(title: "Spending 1 AUD", amount: 2000.05, bgColor: .cardColor1, from: "AUD"),
    BalanceCard(title: "Spending 2 USD", amount: 100.23, bgColor: .cardColor2, from: "USD"),
    BalanceCard(title: "Spending 3 USD", amount: 24.50, bgColor: .cardColor2, from: "USD"),
    BalanceCard(title: "Spending 4 USD", amount: 1500.45, bgColor: .cardColor2, from: "USD")
]

let accounts = [
    ["name": "Fabi", "currency": "€", "to": "EUR"],
    ["name": "Magnusen", "currency": "AU$", "to": "AUD"],
    ["name": "Magnusen", "currency": "€", "to": "EUR"],
    ["name": "Magnusen", "currency": "$", "to": "USD"],
    ["name": "Florian", "currency": "€", "to": "EUR"]
]

// mock-up for simplicity
func convertAmount(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double {
    let amountDouble = Double(amount)
    switch (sourceCurrency, targetCurrency) {
    case ("AUD", "AUD"):
        return amountDouble * 1
    case ("AUD", "EUR"):
        return amountDouble * 0.6169
    case ("AUD", "USD"):
        return amountDouble * 0.6699
    case ("EUR", "AUD"):
        return amountDouble * 1.6191
    case ("EUR", "USD"):
        return amountDouble * 1.0892
    case ("USD", "AUD"):
        return amountDouble * 0.6129
    case ("USD", "EUR"):
        return amountDouble * 0.9191
    case ("USD", "USD"):
        return amountDouble * 1
    case ("EUR", "EUR"):
        return amountDouble * 1
    default:
        return 0
    }
}


enum Currency: String {
    case AUD
    case EUR
    case USD
    
    func getSign() -> String {
        switch self {
        case .AUD:
            return "A$"
        case .EUR:
            return "€"
        case .USD:
            return "$"
        }
    }
}

typealias Money = [Currency: Double]

struct ExchangeRequest {
    let from: Currency
    let to: Currency
    let value: Double
    let rateFrom: Double
    let rateTo: Double
}



// ECB Data provider for ObservableObject

class TransferService: NSObject {
    private var rates: [String: Double] = [:]
    private let baseCurrency = "AUD"

    override init() {
        super.init()
        updateRates()
    }

    func convert(_ amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double? {
        guard let sourceRate = rates[sourceCurrency], let targetRate = rates[targetCurrency] else {
            return nil
        }
        return (amount / sourceRate) * targetRate
    }

    private func updateRates() {
        guard let feedUrl = URL(string: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml") else {
            return
        }
        let parser = XMLParser(contentsOf: feedUrl)!
        parser.delegate = self
        parser.parse()
    }
}

extension TransferService: XMLParserDelegate {
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Currency rates updated")
        // Scale the rates to AUD
        if let audRate = rates[baseCurrency] {
            for currency in rates.keys {
                rates[currency] = rates[currency]! / audRate
            }
            rates[baseCurrency] = 1.0
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Cube" {
            if let currencyCode = attributeDict["currency"], let rateString = attributeDict["rate"], let rate = Double(rateString) {
                rates[currencyCode] = rate
            }
        }
    }
}



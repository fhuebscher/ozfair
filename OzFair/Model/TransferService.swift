//
//  TransferService.swift
//  OzFair
//
//  Created by Florian Huebscher on 10.05.23.
//

import Foundation

let currencyMappings = [
    ["name": "Fabi", "currency": "€", "to": "EUR"],
    ["name": "Magnusen", "currency": "AU$", "to": "AUD"],
    ["name": "Magnusen", "currency": "€", "to": "EUR"],
    ["name": "Magnusen", "currency": "$", "to": "USD"],
    ["name": "Florian", "currency": "€", "to": "EUR"]
]

// Currency Exchange mock-up for MVP simplicity
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

    // Receive ECB exchange currency data asynchronously
    private func updateRates() {
        guard let feedUrl = URL(string: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: feedUrl) { (data, response, error) in
            // Handle the response and error here
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Parse the data here
            if let data = data {
                DispatchQueue.global().async {
                    let parser = XMLParser(data: data)
                    parser.delegate = self
                    parser.parse()
                    
                    // Perform UI updates on the main thread after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // Perform any UI updates or further processing here
                    }
                }
            }
        }
        
        task.resume()
    }
}

// TransferService parsing functions
extension TransferService: XMLParserDelegate {
    // Sets base currency
    func parserDidEndDocument(_ parser: XMLParser) {
        // Scale the rates to AUD
        if let audRate = rates[baseCurrency] {
            for currency in rates.keys {
                rates[currency] = rates[currency]! / audRate
            }
            rates[baseCurrency] = 1.0
        }
    }

    // Parses entries of XML document for each currency
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Cube" {
            if let currencyCode = attributeDict["currency"], let rateString = attributeDict["rate"], let rate = Double(rateString) {
                rates[currencyCode] = rate
            }
        }
    }
}



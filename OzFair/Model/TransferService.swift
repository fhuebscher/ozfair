//
//  TransferService.swift
//  OzFair
//
//  Created by Florian Huebscher on 10.05.23.
//

import Foundation
import RxSwift

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

// class TransferService {
    
//     fileprivate var money = Variable<[Currency: Double]>([:])
    
//     init() {
//         self.money.value = [
//             .EUR: 100,
//             .USD: 100,
//             .AUD: 100
//         ]
//     }
    
//     fileprivate func increase(value: Double, for currency: Currency) {
//         guard let currentValue = self.money.value[currency] else { return }
//         let newValue = currentValue + value
//         self.money.value[currency] = newValue
//     }
    
//     fileprivate func decrease(value: Double, for currency: Currency) {
//         guard let currentValue = self.money.value[currency] else { return }
//         let newValue = currentValue - value
//         self.money.value[currency] = newValue
//     }
    
// }

// extension TransferService {
    
//     func getMoney() -> Observable<Money> {
//         return self.money.asObservable()
//     }
    
//     func process(request: ExchangeRequest) {
//         let increaseValue = request.value * request.rateTo
//         let decreaseValue = request.value * request.rateFrom
        
//         self.increase(value: increaseValue, for: request.to)
//         self.decrease(value: decreaseValue, for: request.from)
//     }
    
// }

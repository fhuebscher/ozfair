//
//  ConverterPresenter.swift
//  OzFair
//
//  Created by Florian Huebscher on 11.05.23.
//

typealias ExchangeMoney = (
    currency: Currency,
    value: Double,
    rate: Double,
    source: ExchangeSource,
    active: Bool
)

struct RatesDisplayable {
    let page: Int
    let currency: Currency
    let rate: Double
    let money: Double
    let source: ExchangeSource
    let exchange: ExchangeMoney
    
    func isActive() -> Bool {
        return source == exchange.source && self.currency == exchange.currency && exchange.active
    }
    
    func canExchange() -> Bool {
        return self.money >= self.exchange.value * self.exchange.rate
    }
    
    func exchangeEnabled() -> Bool {
        return self.exchange.value > 0 && self.canExchange()
    }
    
    func getDisplayableExchangeValue() -> String {
        let value = self.exchange.value * self.rate
        return String(format: "%.2f", value)
    }
}

enum ExchangeSource {
    case from
    case to
}

// class ConverterPresenter {
    
//     weak var view: ConverterView?
    
//     fileprivate var interactorInput: ConverterInteractorInput
    
//     fileprivate var exchangeValue: (from: Variable<ExchangeMoney>, to: Variable<ExchangeMoney>) = (
//         Variable<ExchangeMoney>((.EUR, 0, 1, .from, true)),
//         Variable<ExchangeMoney>((.EUR, 0, 1, .to, false))
//     )
    
//     init(interactorInput: ConverterInteractorInput) {
//         self.interactorInput = interactorInput
//     }
    
//     fileprivate func getRates(from info: RatesMoneyInfo, source: ExchangeSource, exchangeValue: ExchangeMoney) -> [RatesDisplayable] {
//         var page = -1
//         return info.rates.flatMap({ (rateDTO) in
//             guard let currency = rateDTO.currency,
//                 let rate = rateDTO.rate,
//                 let money = info.money[currency] else {
//                     return nil
//             }
            
//             page += 1
//             return RatesDisplayable(
//                 page: page,
//                 currency: currency,
//                 rate: rate,
//                 money: money,
//                 source: source,
//                 exchange: (
//                     currency: exchangeValue.currency,
//                     value: exchangeValue.value,
//                     rate: exchangeValue.rate,
//                     source: exchangeValue.source,
//                     active: exchangeValue.active
//                 )
//             )
//         })
//     }
    
// }

//
//  Definitions.swift
//  OzFair
//
//  Created by Florian Huebscher on 11.05.23.
//


import Foundation
import RxSwift

typealias RatesMoneyInfo = (rates: Rates, money: Money)

class ConverterInteractor {
    
    // TODO add interations
    
    private var exchangeRateConverter: ExchangeRateConverter
    private var transferProvider: TransferProvider
    
    init(exchangeRateConverter: ExchangeRateConverter, transferProvider: TransferProvider) {
        self.exchangeRateConverter = exchangeRateConverter
        self.transferProvider = transferProvider
    }
    
    func getRates() {
        # from getRates -> receiveRates
        
        let timerObservable = Observable<Int>.interval(30, scheduler: MainScheduler.instance).startWith(0)
        let ratesObservable = self.exchangeRateConverter.getRates()
            
        let statusObservable = Observable.combineLatest(ratesObservable, timerObservable)
            .flatMap({ [unowned self] (rates, timer) -> Observable<RatesMoneyInfo> in
                self.transferProvider.getMoney().flatMap({ (money) -> Observable<RatesMoneyInfo> in
                    .just((rates, money))
                })
            })
        
        // TODO connect statusObservable with ConverterPresenter
    }
    

    func exchangeRequested(from: ExchangeMoney, to: ExchangeMoney) {
        let exchangeRequest = ExchangeRequest(from: from.currency, to: to.currency, value: from.value, rateFrom: from.rate, rateTo: to.rate)
        
        self.transferProvider.process(request: exchangeRequest)
    }
}

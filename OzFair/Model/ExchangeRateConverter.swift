//
//  Definitions.swift
//  OzFair
//
//  Created by Florian Huebscher on 10.05.23.
//


import Foundation
import RxSwift


class ExchangeRateConverter {

    let session = URLSession.shared
    
    func getRates() -> Observable<Rates> {
        
        guard let url = URL(string: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml") else {
            fatalError("Should be able to create url")
        }
        let request = URLRequest(url: url)
        
        let fetchObservable = self.session.rx.data(request: request)
            .flatMap({ (data) -> Observable<Rates> in
                let audRate = RateDTO()
                audRate.currency = .AUD
                audRate.rate = 1
                let rates: Rates = [audRate]
                
                let ratesAll = rates + (RatesDTO(xmlData: data)?.getRates() ?? []).filter({ (rate) -> Bool in
                    return rate.currency != nil && rate.rate != nil
                })
                
                return .just(ratesAll)
            })
        
        return fetchObservable
    }
    
}
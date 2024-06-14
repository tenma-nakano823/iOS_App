//
//  CalendarPresenter.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/10.
//

import Foundation

protocol ResponseForCalendar {
    func responseDateManager(response: [String])
    func responseNumberOfWeeks(response: Int)
}

class CalendarPresenter: ResponseForCalendar {

    var viewLogic: ViewLogic?
    
    func responseDateManager(response: [String]) {
        viewLogic?.daysArray = response
    }
    
    func responseNumberOfWeeks(response: Int) {
        viewLogic?.numberOfWeeks = response
    }
    
}

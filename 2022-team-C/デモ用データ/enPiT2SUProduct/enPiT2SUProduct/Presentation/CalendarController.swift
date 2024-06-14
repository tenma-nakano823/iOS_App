//
//  CalendarController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/10.
//

import Foundation

protocol RequestForCalendar: class {
    func requestNumberOfWeeks(request: DateItems.ThisMonth.Request)
    func requestDateManager(request: DateItems.ThisMonth.Request)
    
    func requestNumberOfWeeks(request: DateItems.MoveMonth.Request)
    func requestDateManager(request: DateItems.MoveMonth.Request)
}

class CalendarController: RequestForCalendar {

    var calendarLogic: CalendarLogic?
    
    func requestNumberOfWeeks(request: DateItems.ThisMonth.Request) {
        calendarLogic?.numberOfWeeks(year: request.year, month: request.month)
    }
    
    func requestDateManager(request: DateItems.ThisMonth.Request) {
        calendarLogic?.dateManager(year: request.year, month: request.month)
    }
    
    func requestDateManager(request: DateItems.MoveMonth.Request) {
        calendarLogic?.dateManager(year: request.year, month: request.month)
    }
    
    func requestNumberOfWeeks(request: DateItems.MoveMonth.Request) {
        calendarLogic?.numberOfWeeks(year: request.year, month: request.month)
    }
    
}


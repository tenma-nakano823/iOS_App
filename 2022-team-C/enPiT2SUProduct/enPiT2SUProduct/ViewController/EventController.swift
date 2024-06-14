//
//  EventController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/02.
//

import Foundation
import EventKit

class EventController {
    
    let eventStore: EKEventStore = EKEventStore()
    var todayEvents: [EKEvent]?
    var tomorrowEvents: [EKEvent]?
    var datomorrowEvents: [EKEvent]?
    var detailEvents: [EKEvent]?
    
    
    init(){
        authRequest()
        self.loadEvents()
    }
    
    func authRequest(){
        if EKEventStore.authorizationStatus(for: .event) == .notDetermined{
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if granted && error == nil {
                    print("許可")
                }
            })
        }
    }
    
    func loadEvents() {
        let calendars = eventStore.calendars(for: .event)
        let predicate0 = eventStore.predicateForEvents(withStart: Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!, end: Calendar.current.date(byAdding: .second,value: 86399,to: Calendar.current.startOfDay(for: Date()))!, calendars: calendars)
        todayEvents = eventStore.events(matching: predicate0)
        
        let predicate1 = eventStore.predicateForEvents(withStart: Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!, end: Calendar.current.date(byAdding: .second,value: 172799,to: Calendar.current.startOfDay(for: Date()))!, calendars: calendars)
        tomorrowEvents = eventStore.events(matching: predicate1)
        
        let predicate2 = eventStore.predicateForEvents(withStart: Calendar.current.date(byAdding: .day, value: 2, to: Calendar.current.startOfDay(for: Date()))!, end: Calendar.current.date(byAdding: .second,value: 259199,to: Calendar.current.startOfDay(for: Date()))!, calendars: calendars)
        datomorrowEvents = eventStore.events(matching: predicate2)
    }
    
    func detailloadEvents(year: Int, month: Int, day: Int) {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: year, month: month, day: day))
        
        let calendars = eventStore.calendars(for: .event)
        let predicate3 = eventStore.predicateForEvents(withStart: Calendar.current.date(byAdding: .day,  value: 0, to: Calendar.current.startOfDay(for: date!))!, end: Calendar.current.date(byAdding: .second, value: 86399, to: Calendar.current.startOfDay(for: date!))!, calendars: calendars)
        detailEvents = eventStore.events(matching: predicate3)
    }
}


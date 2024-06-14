//
//  CalendarPlusViewController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/30.
//

import Foundation
import UIKit
import EventKit
import EventKitUI

class CalendarPlusViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newEvent: UILabel!
    @IBOutlet weak var localinfo: UILabel!
    @IBOutlet weak var starttime: UILabel!
    @IBOutlet weak var endtime: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var localButton: UIButton!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var plusbutton: UIButton!
    
    var userDefaults = UserDefaults.standard
    var selectedAddress: String = ""
    
    @IBAction private func clickAddSchedule(_ sender: Any) {
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else { return }
        do {
            try eventStore.save(event, span: .thisEvent)
            //showAlert(title: "登録完了", message: "カレンダーに予定を登録しました。")
            performSegue(withIdentifier: "exit4", sender: nil)
        } catch {
            showAlert(title: "エラー", message: "カレンダーに登録失敗しました。")
        }
    }
    
    private let eventStore = EKEventStore()
    
    private var event: EKEvent {
        let event = EKEvent(eventStore: eventStore)
        event.title = titleTextField.text
        event.startDate = startDatePicker.date
        event.endDate = endDatePicker.date
        event.location = localButton.currentTitle
        event.addAlarm(EKAlarm(relativeOffset: -30*60))
        event.isAllDay = false
        event.url = nil
        event.calendar = eventStore.defaultCalendarForNewEvents
        return event
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        newEvent.backgroundColor = UIColor.clear
        localinfo.backgroundColor = UIColor.clear
        
        starttime.backgroundColor = .white
        starttime.layer.cornerRadius = 10
        starttime.clipsToBounds = true
        
        endtime.backgroundColor = .white
        endtime.layer.cornerRadius = 10
        endtime.clipsToBounds = true
        
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 10
        
        localButton.layer.cornerRadius = 10
        localButton.setTitleColor(UIColor.black, for: .normal)
        localButton.backgroundColor = .white
        localButton.layer.borderColor = UIColor.tintColor.cgColor
        localButton.layer.borderWidth = 1
        
        plusbutton.layer.cornerRadius = 10
        plusbutton.backgroundColor = .white
        plusbutton.layer.borderColor = UIColor.tintColor.cgColor
        plusbutton.layer.borderWidth = 2
        
        /*if loadTest(key: "udTestItem") != nil {
            testitem = loadTest(key: "udTestItem")!
        }*/
        
        titleTextField.delegate = self
        
        localButton.setTitle("登録された住所から選択", for: .normal)
        initializeDatePicker()
        confirmEventStoreAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loadTest(key: "udTestItem") != nil {
            selectedAddress = loadTest(key: "udTestItem")!
        }
        
        print("選んだ住所\(selectedAddress)")
        if (selectedAddress != "") {
            print("ボタンのtitle\(selectedAddress)")
            localButton.setTitle(selectedAddress, for: .normal)
            selectedAddress = ""
            saveTest(items: selectedAddress, key: "udTestItem")
        }
        
        if(localButton.currentTitle != "登録された住所から選択"){
            plusbutton.isEnabled = true
        } else {
            plusbutton.isEnabled = false
        }
    }
    
    private func initializeDatePicker() {
        startDatePicker.date = Date()
        endDatePicker.date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
    }
    
    private func confirmEventStoreAuth() {
        if EKEventStore.authorizationStatus(for: .event) == .notDetermined {
            eventStore.requestAccess(to: .event) { granted, error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else {
                    debugPrint("EKEventStore.authorizationStatus: \(granted)")
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func calendarUnwind1(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func saveTest(items: String, key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func loadTest(key: String) -> String? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let flag = try? jsonDecoder.decode(String.self,
                                                   from: data)
        else {
            return nil
        }
        return flag
    }
}

extension CalendarPlusViewController: EKEventEditViewDelegate {
    //    func eventEditViewControllerDefaultCalendar(
    //        forNewEvents controller: EKEventEditViewController
    //    ) -> EKCalendar {
    //        return eventStore.defaultCalendarForNewEvents!
    //    }
    func eventEditViewController(
        _ controller: EKEventEditViewController,
        didCompleteWith action: EKEventEditViewAction
    ) {
        controller.dismiss(animated: true)
        switch action {
        case .saved:
            //showAlert(title: "登録完了", message: "カレンダーに予定を登録しました。")
            performSegue(withIdentifier: "exit4", sender: nil)
        default: break
        }
    }
}

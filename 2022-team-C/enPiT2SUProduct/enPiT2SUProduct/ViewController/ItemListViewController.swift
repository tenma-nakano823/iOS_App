//
//  ItemListViewController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/11/30.
//

import UIKit
import MapKit
import Dispatch

struct CaleItem: Codable{
    var item : String
    var itemLocation : String
    var check : Int
}

struct LocalID: Codable {
    var latitude : Double
    var longitude : Double
}

class ItemListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    let eventController = EventController()
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var segmentedcontrol: UISegmentedControl!
    
    @IBOutlet weak var daybutton: UIBarButtonItem!
    
    @IBOutlet weak var planlabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    var calendaritem = [CaleItem]() //tableviewに表示する
    var dateArray = [String]() //カレンダーとデータを共有するために日付を格納する配列
    var dateItemArray: [[CaleItem]] = [[],[],[]] //カレンダーのitemを保存する配列
    
    var items2 = [Info2]()
    var points = [[Geof]]()
    var listitems = [[String]]()
    var listitems1 = [[String]]()
    var listitems2 = [[String]]()
    var listitems3 = [[String]]()
    var listitems4 = [[String]]()
    var listitems5 = [[String]]()
    var listitems6 = [[String]]()
    var listitems7 = [[String]]()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var todayDate : Int = 0
    var tomorrowDate : Int = 0
    var datomorrowDate : Int = 0
    var todayID = [LocalID]()
    var tomorrowID = [LocalID]()
    var datomorrowID = [LocalID]()
    
    var checkArray = [String]()
    var provArray = [[CaleItem]]()
    var provArray1 = [[CaleItem]]()
    var emptyItem = [String]()
    var emptyArray = [CaleItem]()
    var duplicationArray = [String]()
    var pluscount : Int = -1
    var count = 0
    var count1 = 0
    var deletecount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "持ち物リスト"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:  "",
            style:  .plain,
            target: nil,
            action: nil
        )
        
        planlabel?.text = ""
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadItems(key: "udListitem") != nil {
            listitems = loadItems(key: "udListitem")!
        }
        if loadItems(key: "udListItem1") != nil {
            listitems1 = loadItems(key: "udListItem1")!
        }
        if loadItems(key: "udListItem2") != nil {
            listitems2 = loadItems(key: "udListItem2")!
        }
        if loadItems(key: "udListItem3") != nil {
            listitems3 = loadItems(key: "udListItem3")!
        }
        if loadItems(key: "udListItem4") != nil {
            listitems4 = loadItems(key: "udListItem4")!
        }
        if loadItems(key: "udListItem5") != nil {
            listitems5 = loadItems(key: "udListItem5")!
        }
        if loadItems(key: "udListItem6") != nil {
            listitems6 = loadItems(key: "udListItem6")!
        }
        if loadItems(key: "udListItem7") != nil {
            listitems7 = loadItems(key: "udListItem7")!
        }
        if loadDate(key: "udDateArray") != nil {
            dateArray = loadDate(key: "udDateArray")!
        }
        if loadCalendarItem(key: "udDateItemArray") != nil {
            dateItemArray = loadCalendarItem(key: "udDateItemArray")!
        }
        
        let df = DateFormatter()
        
         df.dateFormat = "yyyyMMdd"
        
        //曜日の取得(日曜=1,月曜=2,~~,土曜=7)
        var today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day,value: 1, to: Date())!
        let datomorrow = Calendar.current.date(byAdding: .day,value: 2, to: Date())!
        
        todayDate = Calendar.current.component(.weekday, from: today)
        tomorrowDate = Calendar.current.component(.weekday, from: tomorrow)
        datomorrowDate = Calendar.current.component(.weekday, from: datomorrow)
        
        print(todayDate)
        print(tomorrowDate)
        print(datomorrowDate)
        //曜日の取得　終了
        
        
        //今日,明日,明後日でチェックの受け渡しをする
        if (dateArray.count != 0) {
            if (dateArray[0] != df.string(from: Date())) {
                if (dateArray[1] == df.string(from: Date())) {
                    dateItemArray[0] = dateItemArray[1]
                    dateItemArray[1] = dateItemArray[2]
                } else if (dateArray[2] == df.string(from: Date())) {
                    dateItemArray[0] = dateItemArray[2]
                }
            }
            dateArray[0] = df.string(from: Date())
            dateArray[1] = df.string(from: Calendar.current.date(byAdding: .day,value: 1, to: Date())!)
            dateArray[2] = df.string(from: Calendar.current.date(byAdding: .day,value: 2, to: Date())!)
            
        dateoutloop: for i in 0..<3 {
                for j in 3..<dateArray.count {
                    if (dateArray[i] == dateArray[j]) {
                        dateItemArray[i] = dateItemArray[j]
                        dateArray.remove(at: j)
                        dateItemArray.remove(at: j)
                        continue dateoutloop
                    }
                }
            }
            
            saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            saveDate(items: dateArray, key: "udDateArray")
            
        } else {
            dateArray.append(df.string(from: Date()))
            dateArray.append(df.string(from: Calendar.current.date(byAdding: .day,value: 1, to: Date())!))
            dateArray.append(df.string(from: Calendar.current.date(byAdding: .day,value: 2, to: Date())!))
            //dateArray.append(df.string(from: Calendar.current.date(byAdding: .day,value: 3, to: Date())!))
            
            saveDate(items: dateArray, key: "udDateArray")
        }
        //日付の配列リセット終了
        
        //複数選択可能
        tableview.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        if loadItems(key: "udListItem") != nil {
            listitems = loadItems(key: "udListItem")!
        }
        if loadItems(key: "udListItem1") != nil {
            listitems1 = loadItems(key: "udListItem1")!
        }
        if loadItems(key: "udListItem2") != nil {
            listitems2 = loadItems(key: "udListItem2")!
        }
        if loadItems(key: "udListItem3") != nil {
            listitems3 = loadItems(key: "udListItem3")!
        }
        if loadItems(key: "udListItem4") != nil {
            listitems4 = loadItems(key: "udListItem4")!
        }
        if loadItems(key: "udListItem5") != nil {
            listitems5 = loadItems(key: "udListItem5")!
        }
        if loadItems(key: "udListItem6") != nil {
            listitems6 = loadItems(key: "udListItem6")!
        }
        if loadItems(key: "udListItem7") != nil {
            listitems7 = loadItems(key: "udListItem7")!
        }
        if loadDate(key: "udDateArray") != nil {
            dateArray = loadDate(key: "udDateArray")!
        }
        
        if loadCalendarItem(key: "udDateItemArray") != nil {
            dateItemArray = loadCalendarItem(key: "udDateItemArray")!
        }
        
        //イベント取得
        eventController.loadEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if eventController.todayEvents?.count != 0 {
                for i in 0..<eventController.todayEvents!.count {
                    let geocoder = CLGeocoder()
                    if (eventController.todayEvents?[i].location != "" && eventController.todayEvents?[element: i]!.location?.isEmpty != nil) {
                        todayID = []
                        geocoder.geocodeAddressString((eventController.todayEvents?[i].location)!, completionHandler: {(placemarks, error) in
                            self.todayID.append(LocalID(latitude:(placemarks?.first?.location?.coordinate.latitude)!,longitude:(placemarks?.first?.location?.coordinate.longitude)!))
                        })
                    }
                }
            }
            
            if eventController.tomorrowEvents?.count != 0 {
                for i in 0..<eventController.tomorrowEvents!.count {
                    let geocoder = CLGeocoder()
                    if (eventController.tomorrowEvents?[i].location != "" && eventController.tomorrowEvents?[element: i]!.location?.isEmpty != nil) {
                        tomorrowID = []
                        geocoder.geocodeAddressString((eventController.tomorrowEvents?[i].location)!, completionHandler:  {(placemarks, error) in
                            self.tomorrowID.append(LocalID(latitude:(placemarks?.first?.location?.coordinate.latitude)!,longitude:(placemarks?.first?.location?.coordinate.longitude)!))
                        })
                    }
                }
            }
            
            if eventController.datomorrowEvents?.count != 0 {
                for i in 0..<eventController.datomorrowEvents!.count {
                    let geocoder = CLGeocoder()
                    if (eventController.datomorrowEvents?[i].location != "" && eventController.datomorrowEvents?[element: i]!.location?.isEmpty != nil) {
                        datomorrowID = []
                        geocoder.geocodeAddressString((eventController.datomorrowEvents?[i].location)!, completionHandler: {(placemarks, error) in
                            self.datomorrowID.append(LocalID(latitude:(placemarks?.first?.location?.coordinate.latitude)!,longitude:(placemarks?.first?.location?.coordinate.longitude)!))
                        })
                    }
                }
            }
        }
        //イベント取得終了
        
        segmentedcontrol.selectedSegmentIndex = 0
        segmentedcontrol.backgroundColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.1)
        segmentedcontrol.selectedSegmentTintColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.5)
        tableview.delegate = self
        tableview.dataSource = self
        
        //ロード画面追加
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows
        
        let loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = loadingView.center
        activityIndicator.color = UIColor.white
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        label.center = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 90)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "ただいま処理中です..."
        loadingView.addSubview(label)
        
        window!.filter{$0.isKeyWindow}.first?.addSubview(loadingView)
        //ロード画面終了
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
            loadingView.removeFromSuperview()
            //最初の今日の画面を表示する
            count = 0
            count1 = 0
            deletecount = 0
            pluscount = -1
            emptyArray.removeAll()
            emptyItem.removeAll()
            duplicationArray.removeAll()
            provArray.removeAll()
            provArray1.removeAll()
            checkArray.removeAll()
            
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            for i in 0..<dateItemArray[0].count{
                if (dateItemArray[0][i].itemLocation == "共通" && dateItemArray[0][i].check == 1) {
                    checkArray.append(dateItemArray[0][i].item)
                }
            }
            for i in 0..<todayID.count {
                for _ in 0..<points.count {
                    if (points[0].isEmpty != true) {
                        for k in 0..<points[0].count {
                            if (points[0][k].locationaddress != "場所の住所を登録してください。") {
                                let distance = pointDistance(curLat: todayID[i].latitude, curLong: todayID[i].longitude, disLat: points[0][k].latitude, disLong: points[0][k].longitude)
                                if (distance == true) {
                                        provArray.append([])
                                        pluscount += 1
                                        print("今日\(provArray)")
                                    for t in 0..<listitems[k].count {
                                        provArray[pluscount].append(CaleItem(item: listitems[k][t], itemLocation: points[0][k].locationname, check: 0))
                                    }
                                    if (todayDate == 1) {
                                        for t in 0..<listitems1[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems1[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 2) {
                                        for t in 0..<listitems2[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems2[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 3) {
                                        for t in 0..<listitems3[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems3[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 4) {
                                        for t in 0..<listitems4[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems4[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 5) {
                                        for t in 0..<listitems5[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems5[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 6) {
                                        for t in 0..<listitems6[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems6[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (todayDate == 7) {
                                        for t in 0..<listitems7[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems7[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                }else {
                                    print("distanceがfalse")
                                }
                            } else {
                                print("locationnameがから")
                            }
                        }
                    }
                }
            }
            
            print("今日整理後\(provArray)")
            
            for i in 0..<provArray.count {
                while count < provArray[i].count{
                    provArray1 = provArray
                    provArray1[i].remove(at: count)
                    let search = provArray1[i].filter({$0.item == provArray[i][count].item})
                    if(search.isEmpty == true){
                        emptyItem.append(provArray[i][count].item)
                        emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                        provArray[i].remove(at: count)
                        count -= 1
                    }
                    count += 1
                }
                count = 0
                provArray[i].sort { $0.item < $1.item }
            }
            print("同じリスト内の重複以外を格納\(emptyArray)")
            
            for i in 0..<provArray.count {
                while count < provArray[i].count - 1 {
                    let matchCount = provArray[i].filter{$0.item == provArray[i][count].item}.count
                    if (matchCount == 2){
                        provArray[i][count].item.append("　×②")
                    } else if (matchCount == 3){
                        provArray[i][count].item.append("　×③")
                    } else if (matchCount == 4){
                        provArray[i][count].item.append("　×④")
                    } else if (matchCount == 5){
                        provArray[i][count].item.append("　×⑤")
                    } else if (matchCount == 6){
                        provArray[i][count].item.append("　×⑥")
                    } else if (matchCount == 7){
                        provArray[i][count].item.append("　×⑦")
                    } else if (matchCount == 8){
                        provArray[i][count].item.append("　×⑧")
                    } else if (matchCount == 9){
                        provArray[i][count].item.append("　×⑨")
                    } else {
                        provArray[i][count].item.append("　多数")
                    }
                    emptyItem.append(provArray[i][count].item)
                    emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                    provArray[i].removeSubrange(0...(matchCount - 1))
                }
                count = 0
            }
            
            while count1 < dateItemArray[0].count {
                let deleteSearchItem = emptyArray.filter({ $0.item == dateItemArray[0][count1].item })
                if (deleteSearchItem.isEmpty == true) {
                    dateItemArray[0].remove(at: count1)
                    count1 -= 1
                }
                count1 += 1
            }
            
            for p in 0..<dateItemArray[0].count {
                if (dateItemArray[0][p].check == 1) {
                    for q in 0..<emptyArray.count {
                        if (emptyArray[q].item == dateItemArray[0][p].item) {
                            emptyArray[q].check = 1
                        }
                    }
                }
            }
            
            print("同じリスト内の被りを計算後\(provArray)")
            print("同じリスト内の被りを計算後\(emptyArray)")
            dateItemArray[0] = emptyArray
            
            let dic = Dictionary(grouping: emptyItem) { $0 }
            duplicationArray = dic.filter { $1.count > 1 } .map { $0.0 } .sorted()
            print("重複査定duplicate\(duplicationArray)")
            for i in 0..<duplicationArray.count {
                while deletecount < dateItemArray[0].count{
                    if (duplicationArray[i] == dateItemArray[0][deletecount].item){
                        dateItemArray[0].remove(at: deletecount)
                        deletecount -= 1
                    }
                    deletecount += 1
                }
                deletecount = 0
            }
            for i in 0..<duplicationArray.count{
                dateItemArray[0].append(CaleItem(item: duplicationArray[i], itemLocation: "共通",check: 0))
            }
            
            dateItemArray[0].sort(by: {$0.itemLocation < $1.itemLocation})
            
            for i in 0..<checkArray.count {
                for j in 0..<dateItemArray[0].count {
                    if (dateItemArray[0][j].itemLocation == "共通" && dateItemArray[0][j].item == checkArray[i]) {
                        dateItemArray[0][j].check = 1
                    }
                }
            }
            
            print("終了\(dateItemArray[0])")
            
            saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            
            calendaritem = dateItemArray[0]
            
            calendarDayButton()
            
            if(calendaritem.count == 0) {
                planlabel?.text = "予定なし"
                planlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            } else {
                planlabel?.text = ""
            }
            
            tableview.reloadData()
            //最初の今日の画面終了
            
            //明日のデータをロード
            count = 0
            count1 = 0
            deletecount = 0
            pluscount = -1
            emptyArray.removeAll()
            emptyItem.removeAll()
            duplicationArray.removeAll()
            provArray.removeAll()
            provArray1.removeAll()
            checkArray.removeAll()
            
            
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            for i in 0..<dateItemArray[1].count{
                if (dateItemArray[1][i].itemLocation == "共通" && dateItemArray[1][i].check == 1) {
                    checkArray.append(dateItemArray[1][i].item)
                }
            }
            for i in 0..<tomorrowID.count {
                for _ in 0..<points.count {
                    if (points[0].isEmpty != true) {
                        for k in 0..<points[0].count {
                            if (points[0][k].locationaddress != "場所の住所を登録してください。") {
                                let distance = pointDistance(curLat: tomorrowID[i].latitude, curLong: tomorrowID[i].longitude, disLat: points[0][k].latitude, disLong: points[0][k].longitude)
                                if (distance == true) {
                                        provArray.append([])
                                        pluscount += 1
                                        print("provに追加\(provArray)")
                                    for t in 0..<listitems[k].count {
                                        provArray[pluscount].append(CaleItem(item: listitems[k][t], itemLocation: points[0][k].locationname, check: 0))
                                    }
                                    if (tomorrowDate == 1) {
                                        for t in 0..<listitems1[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems1[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 2) {
                                        for t in 0..<listitems2[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems2[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 3) {
                                        for t in 0..<listitems3[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems3[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 4) {
                                        for t in 0..<listitems4[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems4[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 5) {
                                        for t in 0..<listitems5[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems5[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 6) {
                                        for t in 0..<listitems6[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems6[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (tomorrowDate == 7) {
                                        for t in 0..<listitems7[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems7[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                }else {
                                    print("distanceがfalse")
                                }
                            } else {
                                print("locationnameがから")
                            }
                        }
                    }
                }
            }
            
            for i in 0..<provArray.count {
                while count < provArray[i].count{
                    provArray1 = provArray
                    provArray1[i].remove(at: count)
                    let search = provArray1[i].filter({$0.item == provArray[i][count].item})
                    if(search.isEmpty == true){
                        emptyItem.append(provArray[i][count].item)
                        emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                        provArray[i].remove(at: count)
                        count -= 1
                    }
                    count += 1
                }
                count = 0
                provArray[i].sort { $0.item < $1.item }
            }
            print("同じリスト内の重複以外を格納\(emptyArray)")
            
            for i in 0..<provArray.count {
                while count < provArray[i].count - 1 {
                    let matchCount = provArray[i].filter{$0.item == provArray[i][count].item}.count
                    if (matchCount == 2){
                        provArray[i][count].item.append("　×②")
                    } else if (matchCount == 3){
                        provArray[i][count].item.append("　×③")
                    } else if (matchCount == 4){
                        provArray[i][count].item.append("　×④")
                    } else if (matchCount == 5){
                        provArray[i][count].item.append("　×⑤")
                    } else if (matchCount == 6){
                        provArray[i][count].item.append("　×⑥")
                    } else if (matchCount == 7){
                        provArray[i][count].item.append("　×⑦")
                    } else if (matchCount == 8){
                        provArray[i][count].item.append("　×⑧")
                    } else if (matchCount == 9){
                        provArray[i][count].item.append("　×⑨")
                    } else {
                        provArray[i][count].item.append("　多数")
                    }
                    emptyItem.append(provArray[i][count].item)
                    emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                    provArray[i].removeSubrange(0...(matchCount - 1))
                }
                count = 0
            }
            
            while count1 < dateItemArray[1].count {
                let deleteSearchItem = emptyArray.filter({ $0.item == dateItemArray[1][count1].item })
                if (deleteSearchItem.isEmpty == true) {
                    dateItemArray[1].remove(at: count1)
                    count1 -= 1
                }
                count1 += 1
            }
            
            for p in 0..<dateItemArray[1].count {
                if (dateItemArray[1][p].check == 1) {
                    for q in 0..<emptyArray.count {
                        if (emptyArray[q].item == dateItemArray[1][p].item) {
                            emptyArray[q].check = 1
                        }
                    }
                }
            }
            
            print("同じリスト内の被りを計算後\(provArray)")
            print("同じリスト内の被りを計算後\(emptyArray)")
            dateItemArray[1] = emptyArray
            
            let dic1 = Dictionary(grouping: emptyItem) { $0 }
            duplicationArray = dic1.filter { $1.count > 1 } .map { $0.0 } .sorted()
            print("重複査定duplicate\(duplicationArray)")
            for i in 0..<duplicationArray.count {
                while deletecount < dateItemArray[1].count{
                    if (duplicationArray[i] == dateItemArray[1][deletecount].item){
                        dateItemArray[1].remove(at: deletecount)
                        deletecount -= 1
                    }
                    deletecount += 1
                }
                deletecount = 0
            }
            for i in 0..<duplicationArray.count{
                dateItemArray[1].append(CaleItem(item: duplicationArray[i], itemLocation: "共通",check: 0))
            }
            
            dateItemArray[1].sort(by: {$0.itemLocation < $1.itemLocation})
            
            for i in 0..<checkArray.count {
                for j in 0..<dateItemArray[1].count {
                    if (dateItemArray[1][j].itemLocation == "共通" && dateItemArray[1][j].item == checkArray[i]) {
                        dateItemArray[1][j].check = 1
                    }
                }
            }
            
            print("終了\(dateItemArray[1])")
            
            saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            
            //明日のデータのロード終了
            
            //明後日のデータのロード
            count = 0
            count1 = 0
            deletecount = 0
            pluscount = -1
            emptyArray.removeAll()
            emptyItem.removeAll()
            duplicationArray.removeAll()
            provArray.removeAll()
            provArray1.removeAll()
            checkArray.removeAll()
            
            
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            for i in 0..<dateItemArray[2].count{
                if (dateItemArray[2][i].itemLocation == "共通" && dateItemArray[2][i].check == 1) {
                    checkArray.append(dateItemArray[2][i].item)
                }
            }
            for i in 0..<datomorrowID.count {
                for _ in 0..<points.count {
                    if (points[0].isEmpty != true) {
                        for k in 0..<points[0].count {
                            if (points[0][k].locationaddress != "場所の住所を登録してください。") {
                                let distance = pointDistance(curLat: datomorrowID[i].latitude, curLong: datomorrowID[i].longitude, disLat: points[0][k].latitude, disLong: points[0][k].longitude)
                                if (distance == true) {
                                        provArray.append([])
                                        pluscount += 1
                                    for t in 0..<listitems[k].count {
                                        provArray[pluscount].append(CaleItem(item: listitems[k][t], itemLocation: points[0][k].locationname, check: 0))
                                    }
                                    if (datomorrowDate == 1) {
                                        for t in 0..<listitems1[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems1[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 2) {
                                        for t in 0..<listitems2[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems2[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 3) {
                                        for t in 0..<listitems3[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems3[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 4) {
                                        for t in 0..<listitems4[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems4[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 5) {
                                        for t in 0..<listitems5[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems5[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 6) {
                                        for t in 0..<listitems6[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems6[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (datomorrowDate == 7) {
                                        for t in 0..<listitems7[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems7[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                }else {
                                    print("distanceがfalse")
                                }
                            } else {
                                print("locationnameがから")
                            }
                        }
                    }
                }
            }
            
            for i in 0..<provArray.count {
                while count < provArray[i].count{
                    provArray1 = provArray
                    provArray1[i].remove(at: count)
                    let search = provArray1[i].filter({$0.item == provArray[i][count].item})
                    if(search.isEmpty == true){
                        emptyItem.append(provArray[i][count].item)
                        emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                        provArray[i].remove(at: count)
                        count -= 1
                    }
                    count += 1
                }
                count = 0
                provArray[i].sort { $0.item < $1.item }
            }
            print("同じリスト内の重複以外を格納\(emptyArray)")
            
            for i in 0..<provArray.count {
                while count < provArray[i].count - 1 {
                    var matchCount = provArray[i].filter{$0.item == provArray[i][count].item}.count
                    if (matchCount == 2){
                        provArray[i][count].item.append("　×②")
                    } else if (matchCount == 3){
                        provArray[i][count].item.append("　×③")
                    } else if (matchCount == 4){
                        provArray[i][count].item.append("　×④")
                    } else if (matchCount == 5){
                        provArray[i][count].item.append("　×⑤")
                    } else if (matchCount == 6){
                        provArray[i][count].item.append("　×⑥")
                    } else if (matchCount == 7){
                        provArray[i][count].item.append("　×⑦")
                    } else if (matchCount == 8){
                        provArray[i][count].item.append("　×⑧")
                    } else if (matchCount == 9){
                        provArray[i][count].item.append("　×⑨")
                    } else {
                        provArray[i][count].item.append("　多数")
                    }
                    emptyItem.append(provArray[i][count].item)
                    emptyArray.append(CaleItem(item: provArray[i][count].item, itemLocation: provArray[i][count].itemLocation, check: 0))
                    provArray[i].removeSubrange(0...(matchCount - 1))
                }
                count = 0
            }
            
            while count1 < dateItemArray[2].count {
                let deleteSearchItem = emptyArray.filter({ $0.item == dateItemArray[2][count1].item })
                if (deleteSearchItem.isEmpty == true) {
                    dateItemArray[2].remove(at: count1)
                    count1 -= 1
                }
                count1 += 1
            }
            
            for p in 0..<dateItemArray[2].count {
                if (dateItemArray[2][p].check == 1) {
                    for q in 0..<emptyArray.count {
                        if (emptyArray[q].item == dateItemArray[2][p].item) {
                            emptyArray[q].check = 1
                        }
                    }
                }
            }
            
            print("同じリスト内の被りを計算後\(provArray)")
            print("同じリスト内の被りを計算後\(emptyArray)")
            dateItemArray[2] = emptyArray
            
            let dic2 = Dictionary(grouping: emptyItem) { $0 }
            duplicationArray = dic2.filter { $1.count > 1 } .map { $0.0 } .sorted()
            print("重複査定duplicate\(duplicationArray)")
            for i in 0..<duplicationArray.count {
                while deletecount < dateItemArray[2].count{
                    if (duplicationArray[i] == dateItemArray[2][deletecount].item){
                        dateItemArray[2].remove(at: deletecount)
                        deletecount -= 1
                    }
                    deletecount += 1
                }
                deletecount = 0
            }
            for i in 0..<duplicationArray.count{
                dateItemArray[2].append(CaleItem(item: duplicationArray[i], itemLocation: "共通",check: 0))
            }
            
            dateItemArray[2].sort(by: {$0.itemLocation < $1.itemLocation})
            
            for i in 0..<checkArray.count {
                for j in 0..<dateItemArray[2].count {
                    if (dateItemArray[2][j].itemLocation == "共通" && dateItemArray[2][j].item == checkArray[i]) {
                        dateItemArray[2][j].check = 1
                    }
                }
            }
            
            saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            //明後日のデータのロード終了
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if calendaritem.isEmpty == true {
            return 0
        } else {
            return calendaritem.count
        }
    }
    
    //tableviewcellに配列の内容を表示・押されたらチェックマークをつける
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarcell", for:indexPath)
        
        let item = calendaritem[indexPath.row]
        let attributeString0: NSMutableAttributedString = NSMutableAttributedString(string: item.item)
        attributeString0.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString0.length))
        attributeString0.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor(red: 0/0, green: 0/0, blue: 0/0, alpha: 0),  range: NSMakeRange(0, attributeString0.length))
        
        let attributeString1: NSMutableAttributedString = NSMutableAttributedString(string: item.item)
        attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString1.length))
        attributeString1.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.darkGray,  range: NSMakeRange(0, attributeString1.length))
        
        let checkbox = UILabel.init(frame: CGRect(x: self.view.frame.maxX - 45, y:self.view.frame.height / 2, width: 23, height: 23))
        checkbox.textAlignment = NSTextAlignment.center
        checkbox.layer.borderWidth = 2.0
        checkbox.layer.borderColor = UIColor.black.cgColor
        checkbox.layer.cornerRadius = 5
        
        if (item.check == 0){
            checkbox.text = ""
            cell.accessoryView = checkbox
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.text = item.item
            cell.textLabel?.textColor = UIColor.black
            //UIColor(red: 0/0, green: 0/0, blue: 0/0, alpha: 1.0)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.detailTextLabel?.text = item.itemLocation
        } else {
            checkbox.text = "☑️"
            cell.accessoryView = checkbox
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = item.item
            cell.textLabel?.textColor = UIColor.black
            //UIColor(red: 0/0, green: 0/0, blue: 0/0, alpha: 0.6)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 8)
            cell.detailTextLabel?.text = item.itemLocation
        }
        //itemLocationの名称によって色を変更する
        if (item.itemLocation == "共通") {
            cell.detailTextLabel?.textColor = UIColor(red: 255/255, green: 71/255, blue: 51/255, alpha: 0.9)
        } else {
            cell.detailTextLabel?.textColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.7)
        }
        //チェックマーク
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if item.check == 1 {
            cell.textLabel?.attributedText = attributeString1
            cell.backgroundColor = UIColor(red: 213/255, green: 214/255, blue: 219/255, alpha: 0.8)
        } else  if item.check == 0{
            cell.textLabel?.attributedText = attributeString0
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選択されたら背景とチェックをつける
        if calendaritem[indexPath.row].check == 0{
            calendaritem[indexPath.row].check = 1
            if segmentedcontrol.selectedSegmentIndex == 0 {
                dateItemArray[0][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if segmentedcontrol.selectedSegmentIndex == 1{
                dateItemArray[1][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if segmentedcontrol.selectedSegmentIndex == 2 {
                dateItemArray[2][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            }
            //選択されたらチェックを外し背景を元に戻す
        } else if calendaritem[indexPath.row].check == 1{
            calendaritem[indexPath.row].check = 0
            if segmentedcontrol.selectedSegmentIndex == 0 {
                dateItemArray[0][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if segmentedcontrol.selectedSegmentIndex == 1{
                dateItemArray[1][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if segmentedcontrol.selectedSegmentIndex == 2 {
                dateItemArray[2][indexPath.row].check = calendaritem[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            }
        }
        tableview.reloadData()
    }
    
    //セルの高さ固定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if calendaritem[indexPath.row].check == 0 {
            return 62
        } else {
            return 45
        }
    }
    
    //取得したイベントの住所と登録された住所の距離を測る
    func pointDistance(curLat: Double, curLong: Double, disLat: Double, disLong: Double) -> Bool {
        let distance = CLLocation(latitude: curLat, longitude: curLong).distance(from: CLLocation(latitude: disLat, longitude: disLong))
        if (distance <= 100) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            
            calendaritem = dateItemArray[0]
            
            if(calendaritem.count == 0) {
                planlabel?.text = "予定なし"
                planlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            } else {
                planlabel?.text = ""
            }
                tableview.reloadData()
            
        case 1:
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            
            calendaritem = dateItemArray[1]
            
            if(calendaritem.count == 0) {
                planlabel?.text = "予定なし"
                planlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            } else {
                planlabel?.text = ""
            }
            tableview.reloadData()
            
        case 2:
            if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }
            
            calendaritem = dateItemArray[2]
            
            if(calendaritem.count == 0) {
                planlabel?.text = "予定なし"
                planlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            } else {
                planlabel?.text = ""
            }
            tableview.reloadData()
        default:
            fatalError("error")
        }
    }
    
    //テキストフィールドが空のときのデザイン
    @IBAction func EmptyListitems(_ sender: Any) {
        calendarDayButton()
    }
    
    private func calendarDayButton() {
        /*if (listitems[element: 0] == nil){
            daybutton.isEnabled = false
        } else if (listitems[element: 0]![element: 0] == nil){
            daybutton.isEnabled = false
        } else {
            print("else\(listitems)")
            daybutton.isEnabled = true
        }*/
   }
    
    func savePoints(points: [[Geof]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points) else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveItems(items: [[String]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveName(items: [Info2], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveCalendarItem(items: [[CaleItem]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveCalendarID(items: [LocalID], key: String) {
    let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveDate(items: [String], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func loadPoints(key: String) -> [[Geof]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let points = try? jsonDecoder.decode([[Geof]].self,
                                                     from: data)
        else {
            return nil
        }
        return points
    }
    
    func loadItems(key: String) -> [[String]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([[String]].self,
                                                     from: data)
        else {
            return nil
        }
        return items
    }
    
    func loadName(key: String) -> [Info2]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([Info2].self,
                                                  from: data)
        else {
            return nil
        }
        return items
    }
    
    func loadCalendarItem(key: String) -> [[CaleItem]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([[CaleItem]].self,
                                                  from: data)
        else {
            return nil
        }
        return items
    }
    
    func loadCalendarID(key: String) -> [LocalID]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
        let items = try? jsonDecoder.decode([LocalID].self, from: data)
        else {
            return nil
        }
        return items
    }
    
    func loadDate(key: String) -> [String]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
        let items = try? jsonDecoder.decode([String].self, from: data)
        else {
            return nil
        }
        return items
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension Array {
    subscript (safe index: Index) -> Element? {
        //indexが配列内なら要素を返し、配列外ならnilを返す（三項演算子）
        return indices.contains(index) ? self[index] : nil
    }
}

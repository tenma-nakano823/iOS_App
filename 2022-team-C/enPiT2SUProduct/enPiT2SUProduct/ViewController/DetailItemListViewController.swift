//
//  DetailItemListViewController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/10.
//

import UIKit
import MapKit
import Dispatch

class DetailItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let eventController = EventController()
    
    let userDefaults = UserDefaults.standard
    
    var year : Int = 0
    var month : Int = 0
    var day : Int = 0
    var detailDate : Int = 0
    var dateString : String = ""
    var searchcount : Int = 0
    var detailID = [LocalID]()
    var points = [[Geof]]()
    var items2 = [Info2]()
    var listitems = [[String]]()
    var listitems1 = [[String]]()
    var listitems2 = [[String]]()
    var listitems3 = [[String]]()
    var listitems4 = [[String]]()
    var listitems5 = [[String]]()
    var listitems6 = [[String]]()
    var listitems7 = [[String]]()
    //var detailItem = [String]()
    var detailArray = [CaleItem]()
    var dateArray = [String]() //カレンダーとデータを共有するために日付を格納する配列
    var dateItemArray: [[CaleItem]] = [[],[],[]] //カレンダーのitemを保存する配列
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
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var planlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(month)月\(day)日"
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
            print("load\(listitems)")
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
        
        print(year)
        print(month)
        print(day)
        
        
        let detailDay = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        detailDate = Calendar.current.component(.weekday, from: detailDay)
        
        //数字データを文字データに変換し, detailArrayに格納
        var yearString = String(year)
        var monthString = String(month)
        var dayString = String(day)
        
        if (monthString.count == 1){
            monthString.insert("0", at: monthString.startIndex)
        }
        
        if (dayString.count == 1){
            dayString.insert("0", at: dayString.startIndex)
        }
        
        dateString = yearString + monthString + dayString
        
        for i in 0..<dateArray.count {
            if (dateArray[i] == dateString) {
                detailArray = dateItemArray[i]
                break
            }
        }
        //数字データから文字データに変換終了
        
        eventController.detailloadEvents(year: year, month: month, day: day)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if eventController.detailEvents?.count != 0 {
                for i in 0..<eventController.detailEvents!.count {
                    let geocoder = CLGeocoder()
                    if (eventController.detailEvents?[i].location != "" && eventController.detailEvents?[element: i]!.location?.isEmpty != nil) {
                        detailID = []
                        geocoder.geocodeAddressString((eventController.detailEvents?[i].location)!, completionHandler:  {(placemarks, error) in
                            self.detailID.append(LocalID(latitude:(placemarks?.first?.location?.coordinate.latitude)!,longitude:(placemarks?.first?.location?.coordinate.longitude)!))
                        })
                    }
                }
            }
        }
        
        tableview.dataSource = self
        tableview.delegate = self
        
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
            //画面を表示する
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
            
            
            /*if loadCalendarItem(key: "udDateItemArray") != nil {
                dateItemArray = loadCalendarItem(key: "udDateItemArray")!
            }*/
            for i in 0..<detailArray.count{
                if (detailArray[i].itemLocation == "共通" && detailArray[i].check == 1) {
                    checkArray.append(detailArray[i].item)
                }
            }
            
            for i in 0..<detailID.count {
                for _ in 0..<points.count {
                    if (points[0].isEmpty != true) {
                        for k in 0..<points[0].count {
                            if (points[0][k].locationaddress != "場所の住所を登録してください。") {
                                let distance = pointDistance(curLat: detailID[i].latitude, curLong: detailID[i].longitude, disLat: points[0][k].latitude, disLong: points[0][k].longitude)
                                if (distance == true) {
                                        provArray.append([])
                                        pluscount += 1
                                        print("今日\(provArray)")
                                    for t in 0..<listitems[k].count {
                                        provArray[pluscount].append(CaleItem(item: listitems[k][t], itemLocation: points[0][k].locationname, check: 0))
                                    }
                                    if (detailDate == 1) {
                                        for t in 0..<listitems1[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems1[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 2) {
                                        for t in 0..<listitems2[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems2[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 3) {
                                        for t in 0..<listitems3[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems3[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 4) {
                                        for t in 0..<listitems4[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems4[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 5) {
                                        for t in 0..<listitems5[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems5[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 6) {
                                        for t in 0..<listitems6[k].count {
                                            provArray[pluscount].append(CaleItem(item: listitems6[k][t], itemLocation: points[0][k].locationname, check: 0))
                                        }
                                    }
                                    if (detailDate == 7) {
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
            
            while count1 < detailArray.count {
                let deleteSearchItem = emptyArray.filter({ $0.item == detailArray[count1].item })
                if (deleteSearchItem.isEmpty == true) {
                    detailArray.remove(at: count1)
                    count1 -= 1
                }
                count1 += 1
            }
            
            for p in 0..<detailArray.count {
                if (detailArray[p].check == 1) {
                    for q in 0..<emptyArray.count {
                        if (emptyArray[q].item == detailArray[p].item) {
                            emptyArray[q].check = 1
                        }
                    }
                }
            }
            
            print("同じリスト内の被りを計算後\(provArray)")
            print("同じリスト内の被りを計算後\(emptyArray)")
            detailArray = emptyArray
            
            let dic = Dictionary(grouping: emptyItem) { $0 }
            duplicationArray = dic.filter { $1.count > 1 } .map { $0.0 } .sorted()
            print("重複査定duplicate\(duplicationArray)")
            for i in 0..<duplicationArray.count {
                while deletecount < detailArray.count{
                    if (duplicationArray[i] == detailArray[deletecount].item){
                        detailArray.remove(at: deletecount)
                        deletecount -= 1
                    }
                    deletecount += 1
                }
                deletecount = 0
            }
            for i in 0..<duplicationArray.count{
                detailArray.append(CaleItem(item: duplicationArray[i], itemLocation: "共通",check: 0))
            }
            
            detailArray.sort(by: {$0.itemLocation < $1.itemLocation})
            
            for i in 0..<checkArray.count {
                for j in 0..<detailArray.count {
                    if (detailArray[j].itemLocation == "共通" && detailArray[j].item == checkArray[i]) {
                        detailArray[j].check = 1
                    }
                }
            }
            //予定なしの画面表示
            if(detailArray.count == 0) {
                planlabel?.text = "予定なし"
                planlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            } else {
                planlabel?.text = ""
            }
            
            //dateArrayに該当日のアイテムを保存
            if (detailArray.count != 0){
                let detailSearchItem = dateArray.filter({ $0 == dateString })
                if (detailSearchItem.isEmpty != true) {
                    //今日,明日,明後日はdateArrayの0,1,2番目に固定
                    if (dateArray[0] == dateString) {
                        dateItemArray[0] = detailArray
                    } else if (dateArray[1] == dateString) {
                        dateItemArray[1] = detailArray
                    } else if (dateArray[2] == dateString) {
                        dateItemArray[2] = detailArray
                    }
                    //今日,明日,明後日以外のデータを保存
                    //今日,明日,明後日以外のデータは11個まで保存可能 (全部合わせて2週間分になるように)
                    //最近参照したデータが3番目になるようにする
                    
                      else {
                        for i in 3..<dateArray.count {
                            if (dateArray[i] == dateString) {
                                dateArray.remove(at: i)
                                dateItemArray.remove(at: i)
                                dateArray.insert(dateString, at:3)
                                dateItemArray.insert(contentsOf: [detailArray], at:3)
                                break
                            }
                        }
                    }
                } else if (dateArray.count < 14) {
                    dateArray.insert(dateString, at:3)
                    dateItemArray.insert(contentsOf: [detailArray], at:3)
                } else if (dateArray.count >= 14) {
                    dateArray.removeLast()
                    dateItemArray.removeLast()
                    dateArray.insert(dateString, at:3)
                    dateItemArray.insert(contentsOf: [detailArray], at:3)
                }
            }
            //dateArrayに該当日のアイテムを保存 終了
            saveDate(items: dateArray, key: "udDateArray")
            saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            tableview.reloadData()
            
            
            /*
             // MARK: - Navigation
             
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */
            print("dateArray\(dateArray)")
        }
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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailArray.isEmpty == true {
            return 0
        } else {
            return detailArray.count
        }
    }
    
    //tableviewcellに配列の内容を表示・押されたらチェックマークをつける
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcalendarcell", for:indexPath)
        let item = detailArray[indexPath.row]
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
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.detailTextLabel?.text = item.itemLocation
        } else {
            checkbox.text = "☑️"
            cell.accessoryView = checkbox
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = item.item
            cell.textLabel?.textColor = UIColor.black
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
        if detailArray[indexPath.row].check == 0{
            detailArray[indexPath.row].check = 1
            if (dateArray[0] == dateString) {
                dateItemArray[0][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if (dateArray[1] == dateString) {
                dateItemArray[1][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if (dateArray[2] == dateString) {
                dateItemArray[2][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else {
                dateItemArray[3][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            }
            //選択されたらチェックを外し背景を元に戻す
        } else if detailArray[indexPath.row].check == 1{
            detailArray[indexPath.row].check = 0
            if (dateArray[0] == dateString) {
                dateItemArray[0][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if (dateArray[1] == dateString) {
                dateItemArray[1][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else if (dateArray[2] == dateString) {
                dateItemArray[2][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            } else {
                dateItemArray[3][indexPath.row].check = detailArray[indexPath.row].check
                saveCalendarItem(items: dateItemArray, key: "udDateItemArray")
            }
        }
        tableview.reloadData()
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
    
    //セルの高さ固定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if detailArray[indexPath.row].check == 0 {
            return 62
        } else {
            return 45
        }
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
    
    func saveDate(items: [String], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
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
    
    func loadDate(key: String) -> [String]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
        let items = try? jsonDecoder.decode([String].self, from: data)
        else {
            return nil
        }
        return items
    }
}

//
//  LocationViewController.swift
//  sample_1109
//
//  Created by 仲野天真 on 2022/11/09.
//

import UIKit
import MapKit
import CoreLocation

struct Geof: Codable {
    var locationname: String
    var locationaddress: String
    var latitude: Double
    var longitude: Double
    var notification: Bool
    var dateswitch: Bool
}

/*struct Info: Codable{
    var category: String
    var flag: Int
}*/

struct Info2: Codable{
    var location: String
    var flag1: Int
    var lock: Int
    //var notification: Bool
    //var dateswitch: Bool
}

//GeoFenceを格納した配列をエンコード可能にする構造体
struct CodableCircularRegion : Codable {
    var region: CLCircularRegion?
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(region?.identifier)
        try container.encode(region?.center)
        try container.encode(region?.radius)
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let identifier = try container.decode(String.self)
        let center = try container.decode(CLLocationCoordinate2D.self)
        let radius = try container.decode(CLLocationDistance.self)

        region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
    }

    init(_ region: CLCircularRegion) {
        self.region = region
    }
}

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var searchField: UISearchBar!
    
    var lockflag : Int = 0
    var deleteflag : Int = 0
    var editflag : Int = 0
    var editname : String = ""
    var plusname : String = ""
    var categorycount : Int = 0
    var locationNewName = [String]()
    var locationNewItem = [String]()
    var selectedCell: Int = 0
    var removeindex : Int!
    var exittime: Bool = false
    
    var newcategory : String = ""
    var newflag : Int = 0
    let userDefaults = UserDefaults.standard
    
    var items2 : [Info2] = []
    var searchItems = [Info2]()
    var points : [[Geof]] = []
    var listitems : [[String]] = []
    var listitems1 : [[String]] = []
    var listitems2 : [[String]] = []
    var listitems3 : [[String]] = []
    var listitems4 : [[String]] = []
    var listitems5 : [[String]] = []
    var listitems6 : [[String]] = []
    var listitems7 : [[String]] = []
    var switchArray : [[String]] = []
    var historyList = [[String]]()
    var historyList1 = [[String]]()
    var historyList2 = [[String]]()
    var historyList3 = [[String]]()
    var historyList4 = [[String]]()
    var historyList5 = [[String]]()
    var historyList6 = [[String]]()
    var historyList7 = [[String]]()
    
    // 位置情報関連
    var manager1 : CLLocationManager!
    var my_latitude : CLLocationDegrees!
    var my_longitude : CLLocationDegrees!
    var monitoringRegion = [[CodableCircularRegion]]()
    
    var flag2 : Int = 0
    var count : Int = 0
    
    var TC : UIViewController!
    
    func setupSearchBar(){
            searchField.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
    //  検索バーに入力があったら呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            /*guard !searchText == "" else*/
        /*if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }*/
        if (searchField?.text == "") {
                searchItems = items2
                locationtableView.reloadData()
                return
        } else {
            searchItems = items2.filter({ item2 -> Bool in
                item2.location.lowercased().contains(searchText.lowercased())
            })
        }
        
        saveName(items: searchItems, key: "udSearch")
        
            locationtableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "LocationCell")
        let item = searchItems[indexPath.row]
        cell.textLabel?.text = item.location
        return cell
    }
    
    @IBOutlet weak var locationtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchField
        
        extendedLayoutIncludesOpaqueBars = true
        
        searchField.text = ""
        // Do any additional setup after loading the view.
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadItems(key: "udListItem") != nil{
            listitems = loadItems(key: "udListItem")!
        }
        if loadItems(key: "udListItem1") != nil{
            listitems1 = loadItems(key: "udListItem1")!
        }
        if loadItems(key: "udListItem2") != nil{
            listitems2 = loadItems(key: "udListItem2")!
        }
        if loadItems(key: "udListItem3") != nil{
            listitems3 = loadItems(key: "udListItem3")!
        }
        if loadItems(key: "udListItem4") != nil{
            listitems4 = loadItems(key: "udListItem4")!
        }
        if loadItems(key: "udListItem5") != nil{
            listitems5 = loadItems(key: "udListItem5")!
        }
        if loadItems(key: "udListItem6") != nil{
            listitems6 = loadItems(key: "udListItem6")!
        }
        if loadItems(key: "udListItem7") != nil{
            listitems7 = loadItems(key: "udListItem7")!
        }
        if loadItems(key: "udSwitchArray") != nil{
            switchArray = loadItems(key: "udSwitchArray")!
        }
        if loadItems(key: "udHistory") != nil {
            historyList = loadItems(key: "udHistory")!
        }
        if loadItems(key: "udHistory1") != nil {
            historyList1 = loadItems(key: "udHistory1")!
        }
        if loadItems(key: "udHistory2") != nil {
            historyList2 = loadItems(key: "udHistory2")!
        }
        if loadItems(key: "udHistory3") != nil {
            historyList3 = loadItems(key: "udHistory3")!
        }
        if loadItems(key: "udHistory4") != nil {
            historyList4 = loadItems(key: "udHistory4")!
        }
        if loadItems(key: "udHistory5") != nil {
            historyList5 = loadItems(key: "udHistory5")!
        }
        if loadItems(key: "udHistory6") != nil {
            historyList6 = loadItems(key: "udHistory6")!
        }
        if loadItems(key: "udHistory7") != nil {
            historyList7 = loadItems(key: "udHistory7")!
        }
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        manager1 = CLLocationManager()
        manager1!.delegate = self
        manager1.requestWhenInUseAuthorization()
        //Backgroundでの位置情報の更新を許可する
        manager1.allowsBackgroundLocationUpdates = true
        
        if (manager1.authorizationStatus == .authorizedWhenInUse){
            manager1.requestAlwaysAuthorization()
        }
        
        if (manager1.authorizationStatus == .authorizedAlways) {
            manager1.requestLocation()
        }
        
        manager1.desiredAccuracy = kCLLocationAccuracyBest
        manager1.distanceFilter = 1
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        //searchItems = items2
        
        locationtableView.dataSource = self
        locationtableView.delegate = self
        
        locationtableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue") {
            let controller = segue.destination as! EditViewController
            controller.flag2 = editflag
        } else if (segue.identifier == "plusSegue") {
            let controller = segue.destination as! PlusViewController
            saveFlag(items: items2.count, key: "udFlag")
            controller.flag2 = items2.count
        } else if (segue.identifier == "listSegue") {
            if let selectedRow = locationtableView.indexPathForSelectedRow{
                let controller = segue.destination as! ViewController
                controller.info = searchItems[selectedRow.row]
                controller.selectedCell = searchItems[selectedRow.row].flag1
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchField.text = ""
        
        //テーブルを再描画
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
            print("locationviewpoints_load\(points)")
        }
        
        if loadItems(key: "udListItem") != nil{
            listitems = loadItems(key: "udListItem")!
        }
        if loadItems(key: "udListItem1") != nil{
            listitems1 = loadItems(key: "udListItem1")!
        }
        if loadItems(key: "udListItem2") != nil{
            listitems2 = loadItems(key: "udListItem2")!
        }
        if loadItems(key: "udListItem3") != nil{
            listitems3 = loadItems(key: "udListItem3")!
        }
        if loadItems(key: "udListItem4") != nil{
            listitems4 = loadItems(key: "udListItem4")!
        }
        if loadItems(key: "udListItem5") != nil{
            listitems5 = loadItems(key: "udListItem5")!
        }
        if loadItems(key: "udListItem6") != nil{
            listitems6 = loadItems(key: "udListItem6")!
        }
        if loadItems(key: "udListItem7") != nil{
            listitems7 = loadItems(key: "udListItem7")!
        }
        if loadItems(key: "udSwitchArray") != nil{
            switchArray = loadItems(key: "udSwitchArray")!
        }
        
        if loadItems(key: "udHistory") != nil {
            historyList = loadItems(key: "udHistory")!
        }
        if loadItems(key: "udHistory1") != nil {
            historyList1 = loadItems(key: "udHistory1")!
        }
        if loadItems(key: "udHistory2") != nil {
            historyList2 = loadItems(key: "udHistory2")!
        }
        if loadItems(key: "udHistory3") != nil {
            historyList3 = loadItems(key: "udHistory3")!
        }
        if loadItems(key: "udHistory4") != nil {
            historyList4 = loadItems(key: "udHistory4")!
        }
        if loadItems(key: "udHistory5") != nil {
            historyList5 = loadItems(key: "udHistory5")!
        }
        if loadItems(key: "udHistory6") != nil {
            historyList6 = loadItems(key: "udHistory6")!
        }
        if loadItems(key: "udHistory7") != nil {
            historyList7 = loadItems(key: "udHistory7")!
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        searchItems = items2
        
        locationtableView.reloadData()
        
        print("locationviewpoints\(points)")
        print("locationviewmonitoring\(monitoringRegion)")
        
    }
    
    //項目を追加する
    @IBAction func plusbuttonTapped(_ sender: Any) {
        if (listitems.count == items2.count) {
            listitems.append([])
        }
        if (listitems1.count == items2.count) {
            listitems1.append([])
        }
        if (listitems2.count == items2.count) {
            listitems2.append([])
        }
        if (listitems3.count == items2.count) {
            listitems3.append([])
        }
        if (listitems4.count == items2.count) {
            listitems4.append([])
        }
        if (listitems5.count == items2.count) {
            listitems5.append([])
        }
        if (listitems6.count == items2.count) {
            listitems6.append([])
        }
        if (listitems7.count == items2.count) {
            listitems7.append([])
        }
        if (switchArray.count == items2.count) {
            switchArray.append([])
        }
        
        savePoints(points: points, key: "udPoint")
        saveItems(items: listitems, key: "udListItem")
        saveItems(items: listitems1, key: "udListItem1")
        saveItems(items: listitems2, key: "udListItem2")
        saveItems(items: listitems3, key: "udListItem3")
        saveItems(items: listitems4, key: "udListItem4")
        saveItems(items: listitems5, key: "udListItem5")
        saveItems(items: listitems6, key: "udListItem6")
        saveItems(items: listitems7, key: "udListItem7")
        saveItems(items: switchArray, key: "udSwitchArray")
        
        if (monitoringRegion.count == items2.count) {
            monitoringRegion.append([])
            saveRegions(points: monitoringRegion, key: "udRegion")
        }
        if (points.count == 0) {
            points.append([Geof]())
            savePoints(points: points, key: "udPoint")
            
        }
        if (points[0].count == items2.count){
            points[0].append(Geof(locationname: "", locationaddress: "場所の住所を登録してください。", latitude: 0, longitude: 0, notification: true, dateswitch: true))
            savePoints(points: points, key: "udPoint")
        }
        if (historyList.count == items2.count) {
            historyList.append([String]())
            saveItems(items: historyList, key: "udHistory")
        }
        if (historyList1.count == items2.count) {
            historyList1.append([String]())
            saveItems(items: historyList1, key: "udHistory1")
        }
        if (historyList2.count == items2.count) {
            historyList2.append([String]())
            saveItems(items: historyList2, key: "udHistory2")
        }
        if (historyList3.count == items2.count) {
            historyList3.append([String]())
            saveItems(items: historyList3, key: "udHistory3")
        }
        if (historyList4.count == items2.count) {
            historyList4.append([String]())
            saveItems(items: historyList4, key: "udHistory4")
        }
        if (historyList5.count == items2.count) {
            historyList5.append([String]())
            saveItems(items: historyList5, key: "udHistory5")
        }
        if (historyList6.count == items2.count) {
            historyList6.append([String]())
            saveItems(items: historyList6, key: "udHistory6")
        }
        if (historyList7.count == items2.count) {
            historyList7.append([String]())
            saveItems(items: historyList7, key: "udHistory7")
        }
        
        print("plus\(listitems)")
        
        performSegue(withIdentifier: "plusSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedCell = indexPath.row
        // print(mustitems)
        // print(listitems)
        saveItems(items: listitems, key: "udListItem")
        saveItems(items: listitems1, key: "udListItem1")
        saveItems(items: listitems2, key: "udListItem2")
        saveItems(items: listitems3, key: "udListItem3")
        saveItems(items: listitems4, key: "udListItem4")
        saveItems(items: listitems5, key: "udListItem5")
        saveItems(items: listitems6, key: "udListItem6")
        saveItems(items: listitems7, key: "udListItem7")
        saveItems(items: switchArray, key: "udSwitchArray")
        saveItems(items: historyList, key: "udHistory")
        saveItems(items: historyList1, key: "udHistory1")
        saveItems(items: historyList2, key: "udHistory2")
        saveItems(items: historyList3, key: "udHistory3")
        saveItems(items: historyList4, key: "udHistory4")
        saveItems(items: historyList5, key: "udHistory5")
        saveItems(items: historyList6, key: "udHistory6")
        saveItems(items: historyList7, key: "udHistory7")
        
        performSegue(withIdentifier: "listSegue", sender: nil)
    }
    
    // スワイプした時に表示するアクションの定義
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadItems(key: "udListItem") != nil {
            listitems = loadItems(key: "udListItem")!
        }
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        
        if (searchItems[indexPath.row].lock == 0) {
            // 　ロックのアクションを設定する
            let lockAction = UIContextualAction(style: .normal  , title: "lock") { [self]
                (ctxAction, view, completionHandler) in
                searchItems[indexPath.row].lock = 1
                
                if loadName(key: "udName2") != nil {
                    items2 = loadName(key: "udName2")!
                }
                
                for i in 0..<items2.count {
                    if (items2[i].location == searchItems[indexPath.row].location) {
                        items2[i].lock = 1
                        saveName(items: items2, key: "udName2")
                        break
                    }
                }
                
                print("ロックsearch\(searchItems)")
                print("ロックitems2\(items2)")
                
                saveName(items: searchItems, key: "udSearch")
                completionHandler(true)
            }
            // ロックのデザインを設定する
            let lockImage = UIImage(systemName: "lock.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
            lockAction.image = lockImage
            lockAction.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 1)
            
            
            // 削除のアクションを設定する
            let deleteAction = UIContextualAction(style: .destructive, title:"delete") { [self]
                (ctxAction, view, completionHandler) in
                
                if loadName(key: "udName2") != nil {
                    items2 = loadName(key: "udName2")!
                }
                
                
                for i in 0..<items2.count {
                    if (items2[i].location == searchItems[indexPath.row].location) {
                        items2.remove(at: i)
                        for j in 0..<items2.count{
                            items2[j].flag1 = j
                        }
                        saveName(items: items2, key: "udName2")
                        break
                    }
                }
                
                listitems.remove(at: searchItems[indexPath.row].flag1)
                listitems1.remove(at: searchItems[indexPath.row].flag1)
                listitems2.remove(at: searchItems[indexPath.row].flag1)
                listitems3.remove(at: searchItems[indexPath.row].flag1)
                listitems4.remove(at: searchItems[indexPath.row].flag1)
                listitems5.remove(at: searchItems[indexPath.row].flag1)
                listitems6.remove(at: searchItems[indexPath.row].flag1)
                listitems7.remove(at: searchItems[indexPath.row].flag1)
                switchArray.remove(at: searchItems[indexPath.row].flag1)
                historyList.remove(at: searchItems[indexPath.row].flag1)
                historyList1.remove(at: searchItems[indexPath.row].flag1)
                historyList2.remove(at: searchItems[indexPath.row].flag1)
                historyList3.remove(at: searchItems[indexPath.row].flag1)
                historyList4.remove(at: searchItems[indexPath.row].flag1)
                historyList5.remove(at: searchItems[indexPath.row].flag1)
                historyList6.remove(at: searchItems[indexPath.row].flag1)
                historyList7.remove(at: searchItems[indexPath.row].flag1)
                
                if(monitoringRegion[searchItems[indexPath.row].flag1].isEmpty != true) {
                    manager1.stopMonitoring(for: monitoringRegion[searchItems[indexPath.row].flag1][0].region!)
                }
                
                monitoringRegion.remove(at: searchItems[indexPath.row].flag1)
                print(manager1.monitoredRegions)
                saveRegions(points: monitoringRegion, key: "udRegion")
                
                points[0].remove(at: searchItems[indexPath.row].flag1)
                
                searchItems.remove(at: indexPath.row)
                
            outloop: for i in 0..<searchItems.count {
                    for j in 0..<items2.count {
                        if (searchItems[i].location == items2[j].location) {
                            searchItems[i].flag1 = items2[j].flag1
                            continue outloop
                        }
                    }
                }
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                saveName(items: searchItems, key: "udSearch")
                savePoints(points: points, key: "udPoint")
                saveRegions(points: monitoringRegion, key: "udRegion")
                
                
                saveItems(items: listitems, key: "udListItem")
                saveItems(items: listitems1, key: "udListItem1")
                saveItems(items: listitems2, key: "udListItem2")
                saveItems(items: listitems3, key: "udListItem3")
                saveItems(items: listitems4, key: "udListItem4")
                saveItems(items: listitems5, key: "udListItem5")
                saveItems(items: listitems6, key: "udListItem6")
                saveItems(items: listitems7, key: "udListItem7")
                saveItems(items: switchArray, key: "udSwitchArray")
                saveItems(items: historyList, key: "udHistory")
                saveItems(items: historyList1, key: "udHistory1")
                saveItems(items: historyList2, key: "udHistory2")
                saveItems(items: historyList3, key: "udHistory3")
                saveItems(items: historyList4, key: "udHistory4")
                saveItems(items: historyList5, key: "udHistory5")
                saveItems(items: historyList6, key: "udHistory6")
                saveItems(items: historyList7, key: "udHistory7")
                
                //print(items2)
                //print(lockitems2)
                
                print("削除したよpoints\(points)")
                completionHandler(true)
            }
            // 削除ボタンのデザインを設定する
            let trashImage = UIImage(systemName: "trash.fill")?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
            deleteAction.image = trashImage
            deleteAction.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            
            // スワイプでの削除を無効化して設定する
            let swipeAction = UISwipeActionsConfiguration(actions:[deleteAction, lockAction])
            swipeAction.performsFirstActionWithFullSwipe = false
            
            return swipeAction
            
        }else {
            // 　アンロックのアクションを設定する
            let unlockAction = UIContextualAction(style: .normal  , title: "lock") { [self]
                (ctxAction, view, completionHandler) in
                searchItems[indexPath.row].lock = 0
                
                if loadName(key: "udName2") != nil {
                    items2 = loadName(key: "udName2")!
                }
                
                for i in 0..<items2.count {
                    if (items2[i].location == searchItems[indexPath.row].location) {
                        items2[i].lock = 0
                        saveName(items: items2, key: "udName2")
                        break
                    }
                }
                
                print("アンロックsearch\(searchItems)")
                print("アンロックitems2\(items2)")
                
                saveName(items: searchItems, key: "udSearch")
                completionHandler(true)
            }
            // アンロックのデザインを設定する
            let lockImage = UIImage(systemName: "lock.open.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
            unlockAction.image = lockImage
            unlockAction.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 1)
            
            // スワイプでの削除を無効化して設定する
            let swipeAction = UISwipeActionsConfiguration(actions:[unlockAction])
            swipeAction.performsFirstActionWithFullSwipe = false
            
            return swipeAction
        }
    }
    
    //編集スワイプ
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (action, view, completionHandler) in
            
            //処理を記述
            editflag = searchItems[indexPath.row].flag1
            
            saveFlag(items: editflag, key: "udFlag")
            performSegue(withIdentifier: "editSegue", sender: nil)
            
        }
        
        let editImage = UIImage(systemName: "pencil")?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
        editAction.image = editImage
        editAction.backgroundColor = UIColor.systemBlue
        
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    
    //項目が追加された時の遷移元の処理
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {

    }
    
    @IBAction func unwind1(_ unwindSegue: UIStoryboardSegue) {
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
    
    func saveRegions(points: [[CodableCircularRegion]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveFlag(items: Int, key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func loadFlag(key: String) -> Int? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let flag = try? jsonDecoder.decode(Int.self,
                                                   from: data)
        else {
            return nil
        }
        return flag
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
    
    func loadRegions(key: String) -> [[CodableCircularRegion]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let regions = try? jsonDecoder.decode([[CodableCircularRegion]].self, from: data) else {
            return nil
        }
        return regions
    }
    
    func getTopMostViewController() -> UIViewController{
        TC = UIApplication.shared.windows.first {$0.isKeyWindow }?.rootViewController
            while TC?.presentedViewController != nil {
                TC = TC?.presentedViewController;
            }
        let AfterVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style:.plain, target: self,
                                         action: #selector(AfterVC.backButtonTapped(_:)))
        TC.navigationItem.leftBarButtonItem = leftButton

            return TC
        }
    
    func ChangeVC(f1: Int){
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        print(f1)
        let AfterVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: AfterVC)
        navigationController.modalPresentationStyle = .fullScreen

        AfterVC.info = items2[f1]
        AfterVC.selectedCell = items2[f1].flag1
        print(AfterVC.info!)
        
        TC.present(navigationController, animated: true, completion: nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager1: CLLocationManager){
        let status = manager1.authorizationStatus
        switch status {
        case .notDetermined:
            print("ユーザー認証未選択")
            break
        case .denied:
            print("ユーザーが位置情報取得を拒否しています。")
            //位置情報取得を促す処理を追記
        case .restricted:
            print("位置情報サービスを利用できません")
            break
        case .authorizedWhenInUse:
            print("アプリケーション起動時のみ、位置情報の取得を許可されています。")
            manager1.requestLocation()
            break
        case .authorizedAlways:
            print("このアプリケーションは常時、位置情報の取得を許可されています。")
            break
        default:
            print("default")
            break
        }
        
    }
    
    
    func locationManager(_ manager1: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locations : \(locations)")
    }
    func locationManager(_ manager1: CLLocationManager, didFailWithError error: Error) {
        print("error : \(error)")
    }
    
    // ジオフェンスモニタリング
    // モニタリング開始成功時に呼ばれる
    func locationManager(_ manager1: CLLocationManager, didStartMonitoringFor monitoringRegion: CLRegion) {
        print("モニタリング開始")
    }
    // モニタリングに失敗したときに呼ばれる
    func locationManager(_ manager1: CLLocationManager, monitoringDidFailFor monitoringRegion: CLRegion?, withError error: Error) {
        print("モニタリングに失敗しました。")
    }
    
    func locationManager(_ manager1: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter")
        print(region)
        // マップに30分滞在し、範囲を出たら通知する。このデータはデモ用として通知を確認するため、5秒に設定しています。
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
    }
    
    func locationManager(_ manager1: CLLocationManager, didExitRegion region: CLRegion) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(region.identifier)
        appDelegate.identifier = region.identifier
        
        if region is CLCircularRegion {
            print("exit")
            if (exittime == true){
                let content = UNMutableNotificationContent()
                
                content.title = ""
                content.body = "登録した場所から離れました。持ち物リストを変更しますか？"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                exittime = false
            }
        }

    }
    
    @objc private func timerUpdate() {
      // 30分経った判定をする
        exittime = true
    }
}


extension Array {
    subscript (element index: Index) -> Element? {
        //　MARK: 配列の要素以上を指定していたらnilを返すようにする
        indices.contains(index) ? self[index] : nil
    }
}

//CLLocationCoodinate2Dをエンコード可能にする
extension CLLocationCoordinate2D: Codable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let longitude = try container.decode(CLLocationDegrees.self)
        let latitude = try container.decode(CLLocationDegrees.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}


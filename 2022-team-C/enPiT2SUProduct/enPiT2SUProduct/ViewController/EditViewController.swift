//
//  EditViewController.swift
//  sample_1109
//
//  Created by 仲野天真 on 2022/11/11.
//

import UIKit
import CoreLocation

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var etableView: UITableView!
    
    var userDefaults = UserDefaults.standard
    
    var setting: Array = ["通知設定","曜日別のリスト"]
    var sectionItem: Array = ["場所の名前","位置情報","設定"]
    var footerItem : Array = ["","","通知は登録された場所に一定時間滞在した後、\n  離れた際にリストの変更を促します。"]
    
    var flag2: Int = 0
    var text: String = ""
    var selectedcell: Int = 0
    var switcher: Bool = true
    var count: Int = 0
    var removeindex: Int!
    
    var points = [[Geof]]()
    var elocationItem = [[Geof]]()
    var epplocationItem = [Geof]()
    var items2 = [Info2]()
    var pplocationName = String()
    
    var deleteindex = [Int]()
    
    var manager1 : CLLocationManager!
    var monitoringRegion = [[CodableCircularRegion]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return 1
        } else if (section == 2){
            return 2
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionItem.count
    }
    
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String? {
       return sectionItem[section] as? String
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x:10, y:-20, width: tableView.bounds.width, height: 50))
        label.text = "  \(sectionItem[section])"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.italicSystemFont(ofSize: 13)
        //label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        label.textColor =  UIColor.systemGray2
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x:10, y:-6, width: tableView.bounds.width, height: 50))
        label.numberOfLines = 0
        label.text = "  \(footerItem[section])"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.italicSystemFont(ofSize: 13)
        //label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        label.textColor =  UIColor.systemGray2
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationNameCell", for: indexPath) as! LocationNameCell
        
        
        switch indexPath.section {
        case 0:
            cell.locationnameTextfield?.text = points[0][flag2].locationname
            cell.locationnameTextfield?.textColor = .black
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "LocationAddressCell", for: indexPath) as! LocationAddressCell
            cell1.selectionStyle = .none
            if (points[0][flag2].locationaddress == "場所の住所を登録してください。" || points[0][flag2].locationaddress == "") {
                cell1.locationaddress?.text = "場所の住所を登録してください。"
                cell1.locationaddress?.textColor = UIColor.systemGray2
            } else {
                cell1.locationaddress?.text = points[0][flag2].locationaddress
                cell1.locationaddress?.textColor = .black
            }
            cell1.accessoryType = .disclosureIndicator
            return cell1
        case 2:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            cell2.settinglabel?.text = setting[indexPath.row]
            cell2.settinglabel?.font = UIFont.italicSystemFont(ofSize: 16)
            cell2.selectionStyle = .none
            cell2.settingswitch.tag = indexPath.row
            if (indexPath.row == 0){
                cell2.settingswitch.isOn = points[0][flag2].notification
            } else if(indexPath.row == 1){
                cell2.settingswitch.isOn = points[0][flag2].dateswitch
            }
            cell2.settingswitch.addTarget(self, action: #selector(changeSwitch(_:)), for: UIControl.Event.valueChanged)
            return cell2
        default:
            return cell
        }
    }
    
    @objc func changeSwitch(_ sender: UISwitch) {
        /*
         sender.tagにはスイッチのセルの位置が入る(Int)
         sender.isOnにはスイッチのon/off情報が入る(Bool)
         下のprint文はセル内のラベルの内容とスイッチのTrue/False
         */
        print("switch動作")
    }
    
    //削除スワイプ
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (tableView.tag == 0){
            if editingStyle == .delete{
                if switcher == true {
                    manager1.stopMonitoring(for: monitoringRegion[flag2][indexPath.row].region!)
                }
                monitoringRegion[flag2].remove(at: indexPath.row)
                elocationItem[flag2].remove(at: indexPath.row)
                saveName(items: items2, key: "udName2")
                savePoints(points: elocationItem, key: "udPoint")
                saveRegions(points: monitoringRegion, key: "udRegion")
                
                print(manager1.monitoredRegions)
                
                etableView.beginUpdates()
                etableView.deleteRows(at: [indexPath], with: .fade)
                etableView.endUpdates()
            }
        }
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1){
            performSegue(withIdentifier: "locationMapSegue", sender: nil)
        }
    }
    
    /*@IBAction func notificationSettingChanged(_ sender: UISwitch) {
        self.view.endEditing(true)
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if (notificationSwitch.isOn == true){
            items2[flag2].notification = true
            for i in 0 ..< (elocationItem[flag2].count) {
                let monitoringCoodinate = CLLocationCoordinate2DMake(elocationItem[flag2][i].latitude,
                                                                     elocationItem[flag2][i].longitude)
                monitoringRegion[flag2] += [CodableCircularRegion.init(CLCircularRegion(center: monitoringCoodinate,
                                     radius: CLLocationDistance(100), identifier: elocationItem[flag2][i].locationname))]
                manager1.startMonitoring(for: monitoringRegion[flag2][monitoringRegion[flag2].endIndex - 1].region!)
                saveName(items: items2, key: "udName2")
                saveRegions(points: monitoringRegion, key: "udRegion")
            }
        }else {
            items2[flag2].notification = false
            monitoringRegion[flag2].removeAll()
            saveName(items: items2, key: "udName2")
            saveRegions(points: monitoringRegion, key: "udRegion")
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        let Nib = UINib(nibName: "LocationNameCell", bundle: Bundle.main)
        let secondNib = UINib(nibName: "LocationAddressCell", bundle: Bundle.main)
        let thirdNib = UINib(nibName: "SettingCell", bundle: Bundle.main)
        
        etableView.register(Nib, forCellReuseIdentifier: "LocationNameCell")
        etableView.register(secondNib, forCellReuseIdentifier: "LocationAddressCell")
        etableView.register(thirdNib, forCellReuseIdentifier: "SettingCell")
        
        etableView.rowHeight = 60
        etableView.layer.cornerRadius = 10
        etableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
            //epplocationItem = elocationItem[flag2]
            //etableView.reloadData()
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
            //locationName.text = items2[flag2].location
            //pplocationName = items2[flag2].location
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        
        manager1 = CLLocationManager()
        manager1.delegate = self
        
        etableView.dataSource = self
        etableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if loadPoints(key: "udPoint") != nil {
            elocationItem = loadPoints(key: "udPoint")!
            etableView.reloadData()
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        
        etableView.reloadData()
        
      //テーブルを再描画
      //Etableview.reloadData()
        //ENitem.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if (segue.identifier == "edittomap") {
            if loadPoints(key: "udPoint") != nil {
                points = loadPoints(key: "udPoint")!
            }
            let controller = segue.destination as! MapViewController
            controller.flag2 = flag2
            controller.switcher = points[0][flag2].notification
        }
        else if (segue.identifier == "locationMapSegue"){
            if loadPoints(key: "udPoint") != nil {
                points = loadPoints(key: "udPoint")!
            }
            let controller = segue.destination as! LocationMapViewController
            controller.flag2 = flag2
            //controller.index = selectedcell
            controller.switcher = points[0][flag2].notification
        }
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }*/
    
    
    func savePoints(points: [[Geof]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points) else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func saveItems(items: [[String]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items) else {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

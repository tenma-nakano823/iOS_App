//
//  PlusViewController.swift
//  sample_1109
//
//  Created by 仲野天真 on 2022/11/11.
//

import UIKit
import CoreLocation

class PlusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, CLLocationManagerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var decidebutton: UIBarButtonItem!
    
    @IBOutlet weak var ptableView: UITableView!
    
    var userDefaults = UserDefaults.standard
    
    var setting: Array = ["通知設定","曜日別のリスト"]
    var sectionItem: Array = ["場所の名前","位置情報","設定"]
    var footerItem : Array = ["","","通知は登録された場所に一定時間滞在し後、\n  離れた際にリストの変更を促します。"]
    
    var index: Int = 0
    var flag2: Int = 0
    var tag: Int = 0
    var cellIdentifier: String = ""
    var text: String = ""
    var selectedcell : Int = 0
    var removeindex: Int!
    
    var points = [[Geof]]()
    var items2 = [Info2]()
    var listitems = [[String]]()
    var listitems1 : [[String]] = []
    var listitems2 : [[String]] = []
    var listitems3 : [[String]] = []
    var listitems4 : [[String]] = []
    var listitems5 : [[String]] = []
    var listitems6 : [[String]] = []
    var listitems7 : [[String]] = []
    
    var manager : CLLocationManager!
    var monitoringRegion = [[CodableCircularRegion]]()
    
    @IBAction func backbuttonTapped(_ sender: Any) {
        //self.view.endEditing(true) (switchのロードに干渉してたので消してます)
        if (points[0][flag2].locationname == ""){
            let alert = UIAlertController(title: "削除しますか？", message: nil, preferredStyle: .alert)
            
            let doneAction = UIAlertAction(title: "はい", style:  .default) { [self] _ in
                print("削除前\(points)")
                print("削除前\(listitems)")
                print("削除前\(listitems1)")
                print("削除前\(listitems2)")
                print("削除前\(listitems3)")
                print("削除前\(listitems4)")
                print("削除前\(listitems5)")
                print("削除前\(listitems6)")
                print("削除前\(listitems7)")
                _ = listitems.removeLast()
                _ = listitems1.removeLast()
                _ = listitems2.removeLast()
                _ = listitems3.removeLast()
                _ = listitems4.removeLast()
                _ = listitems5.removeLast()
                _ = listitems6.removeLast()
                _ = listitems7.removeLast()
                _ = points[0].removeLast()
                savePoints(points: points, key: "udPoint")
                saveItems(items: listitems, key: "udListItem")
                saveItems(items: listitems1, key: "udListItem1")
                saveItems(items: listitems2, key: "udListItem2")
                saveItems(items: listitems3, key: "udListItem3")
                saveItems(items: listitems4, key: "udListItem4")
                saveItems(items: listitems5, key: "udListItem5")
                saveItems(items: listitems6, key: "udListItem6")
                saveItems(items: listitems7, key: "udListItem7")
                if (points[0].count != monitoringRegion.count){
                    monitoringRegion.removeLast()
                    saveRegions(points: monitoringRegion, key: "udRegion")
                }
                print("削除後\(points)")
                print("削除後\(listitems)")
                print("削除後\(listitems1)")
                print("削除後\(listitems2)")
                print("削除後\(listitems3)")
                print("削除後\(listitems4)")
                print("削除後\(listitems5)")
                print("削除後\(listitems6)")
                print("削除後\(listitems7)")
                
                performSegue(withIdentifier: "exit", sender: nil)
            }
            
            let cancelAction = UIAlertAction(title: "いいえ", style: .default)
            
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "保存しますか？", message: nil, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "はい", style:  .default) { [self] _ in
                if loadPoints(key: "udPoint") != nil {
                    points = loadPoints(key: "udPoint")!
                }
                print("アラートからの保存\(points[0][flag2].dateswitch)")
                self.decidebuttonTapped(self)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .default) { [self] _ in
                _ = listitems.removeLast()
                _ = listitems1.removeLast()
                _ = listitems2.removeLast()
                _ = listitems3.removeLast()
                _ = listitems4.removeLast()
                _ = listitems5.removeLast()
                _ = listitems6.removeLast()
                _ = listitems7.removeLast()
                _ = points[0].removeLast()
                savePoints(points: points, key: "udPoint")
                saveItems(items: listitems, key: "udListItem")
                saveItems(items: listitems1, key: "udListItem1")
                saveItems(items: listitems2, key: "udListItem2")
                saveItems(items: listitems3, key: "udListItem3")
                saveItems(items: listitems4, key: "udListItem4")
                saveItems(items: listitems5, key: "udListItem5")
                saveItems(items: listitems6, key: "udListItem6")
                saveItems(items: listitems7, key: "udListItem7")
                if (points[0].count != monitoringRegion.count){
                    monitoringRegion.removeLast()
                    saveRegions(points: monitoringRegion, key: "udRegion")
                }
                
                performSegue(withIdentifier: "exit", sender: nil)
            }
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
    
    @IBAction func decidebuttonTapped(_ sender: Any) {
        //saveItems(items: mustitems, key: "udMustItem")
        //savePoints(points: points, key: "udPoint")
        //self.view.endEditing(true) (switchのロードに干渉してたので消してます)
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        //print("追加のとき\(points)")
        text = points[0][flag2].locationname
        items2.append(Info2(location: text, flag1: flag2, lock: 0))
        
        saveName(items: items2, key: "udName2")
        text = ""
        //print("追加したitems2\(items2)")
        print("decidebutton.date.\(points[0][flag2].dateswitch)")
        
        performSegue(withIdentifier: "toItemView", sender: nil)
    }
    
    //テキストフィールドが空のときのデザイン
    /*@IBAction func textEditingDidChanged(_ sender: Any) {
        updateTextFieldButton()
    }
    
    private func updateTextFieldButton() {
        if Pname.text!.trimmingCharacters(in: .whitespaces) == "" {
         decidebutton.isEnabled = false
         decidebutton.layer.opacity = 0.4
     } else {
         decidebutton.isEnabled = true
         decidebutton.layer.opacity = 1
     }
   }*/
    //テキストフィールドが空のときのデザイン　終了

        
    //元の画面に戻るときにアラートを表示するかどうか
    /*
     @IBAction private func showAlert() {
     let alert = UIAlertController(title: "追加するカテゴリ",message: nil,preferredStyle: .alert)
     
     let doneAction = UIAlertAction(title:"はい", style: .default) { [self] _ in
     Pname.text = ""
     performSegue(withIdentifier: "plusSegue", sender: nil)
     }
     
     let cancelAction = UIAlertAction(title: "いいえ", style: .cancel)
     
     alert.addAction(doneAction)
     alert.addAction(cancelAction)
     present(alert, animated: true)
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateTextFieldButton()
        
        manager = CLLocationManager()
        manager.delegate = self
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        let Nib = UINib(nibName: "LocationNameCell", bundle: Bundle.main)
        let secondNib = UINib(nibName: "LocationAddressCell", bundle: Bundle.main)
        let thirdNib = UINib(nibName: "SettingCell", bundle: Bundle.main)
        
        ptableView.register(Nib, forCellReuseIdentifier: "LocationNameCell")
        ptableView.register(secondNib, forCellReuseIdentifier: "LocationAddressCell")
        ptableView.register(thirdNib, forCellReuseIdentifier: "SettingCell")
        
        ptableView.rowHeight = 60
        ptableView.layer.cornerRadius = 10
        ptableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        // Do any additional setup after loading the view.
        ptableView.delegate = self
        ptableView.dataSource = self
        
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
            ptableView.reloadData()
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
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        print("diditems2\(items2)")
        print("didpoints\(points)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
            ptableView.reloadData()
        }
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        
        print("willpoints\(points)")
        print("will,region\(monitoringRegion)")
        
        ptableView.reloadData()
    }
    
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
            cell.locationnameTextfield?.textColor = .black
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "LocationAddressCell", for: indexPath) as! LocationAddressCell
            cell1.selectionStyle = .none
            if (points[0][flag2].locationaddress == "場所の住所を登録してください。") {
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
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        print("changeSwitch.\(points[0][flag2].dateswitch)")
        print("switch動作")
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (tableView.tag == 0){
            if editingStyle == .delete{
                if notificationSwitch.isOn == true {
                    manager.stopMonitoring(for: monitoringRegion[flag2][indexPath.row].region!)
                }
                
                monitoringRegion[flag2].remove(at: indexPath.row)
                
                points[flag2].remove(at: indexPath.row)
                saveName(items: items2, key: "udName2")
                savePoints(points: points, key: "udPoint")
                saveRegions(points: monitoringRegion, key: "udRegion")
                
                print(manager.monitoredRegions)
                
                ptableView.beginUpdates()
                ptableView.deleteRows(at: [indexPath], with: .fade)
                ptableView.endUpdates()
            }
        }
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            self.performSegue(withIdentifier: "plustomap", sender: nil)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.view.endEditing(true) (switchのロードに干渉してたので消してます)
        if (segue.identifier == "plustomap") {
            if loadPoints(key: "udPoint") != nil {
                points = loadPoints(key: "udPoint")!
            }
            let controller = segue.destination as! MapViewController
            controller.flag2 = flag2
            controller.switcher = points[0][flag2].notification
        } else if (segue.identifier == "plusLocationMapSegue"){
            if loadPoints(key: "udPoint") != nil {
                points = loadPoints(key: "udPoint")!
            }
            let controller = segue.destination as! LocationMapViewController
            controller.flag2 = flag2
            //controller.index = selectedcell
            controller.switcher = points[0][flag2].notification
        } else if (segue.identifier == "toItemView"){
            /*if loadPoints(key: "udPoint") != nil {
                points = loadPoints(key: "udPoint")!
            }*/
            print("遷移.\(points[0][flag2].dateswitch)")
            let controller = segue.destination as! ViewController
            controller.info = items2[flag2]
            controller.selectedCell = flag2
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if (segue.identifier == "plusSegue") || (Pname.text?.isEmpty ?? true) {
     let controller = segue.destination as! LocationViewController
     controller.plusname = Pname.text!
     }
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

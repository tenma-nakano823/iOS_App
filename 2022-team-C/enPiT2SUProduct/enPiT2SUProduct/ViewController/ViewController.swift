//
//  ViewController.swift
//  free
//
//  Created by 益子　陸 on 2022/11/09.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var mainView: UIView!
    
    let userDefaults = UserDefaults.standard
    var section1:[String] = ["持ち物リスト"]
    var section2:[String] = ["共通", "日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
    var section3:[String] = ["日","月","火","水","木","金","土"]
    var flag1 : Int = 0
    var info : Info2!
    var mustitems = [[String]]()
    var listitems = [[String]]()
    var checkmark = [Int]()
    var checkmark1 = [Int]()
    var checkmark2 = [Int]()
    var checkmark3 = [Int]()
    var checkmark4 = [Int]()
    var checkmark5 = [Int]()
    var checkmark6 = [Int]()
    var checkmark7 = [Int]()
    var selectedCell : Int = 0
    var savePaths = [IndexPath]()
    var i : Int = 0
    var newtext : String = ""
    var titles = [String]()
    var FirstFlag = 1
    var copyarray = [String]()
    var listitems1 = [[String]]()
    var listitems2 = [[String]]()
    var listitems3 = [[String]]()
    var listitems4 = [[String]]()
    var listitems5 = [[String]]()
    var listitems6 = [[String]]()
    var listitems7 = [[String]]()
    var switchArray = [[String]]()
    var historyList = [[String]]()
    var historyList1 = [[String]]()
    var historyList2 = [[String]]()
    var historyList3 = [[String]]()
    var historyList4 = [[String]]()
    var historyList5 = [[String]]()
    var historyList6 = [[String]]()
    var historyList7 = [[String]]()
    var hukugen = [[String]]()
    var deleteList = [[String]]()
    var indexPath_section:Int = 0
    var copycheck : Int = 0
    var points = [[Geof]]()
    var items2 : [Info2] = []
    var monitoringRegion = [[CodableCircularRegion]]()
    var Balloonflag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = info.location
        //各リストアイテムの読み込み
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
        if loadItems(key: "udSwitchArray") != nil {
            switchArray = loadItems(key: "udSwitchArray")!
        }
        if loadItems2(key: "udCopyArray") != nil {
            copyarray = loadItems2(key: "udCopyArray")!
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
        if loadItems(key: "udHukugen") != nil {
            hukugen = loadItems(key: "udHukugen")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        if loadFlag(key: "udBalloonflag") != nil {
            Balloonflag = loadFlag(key: "udBalloonflag")!
        }
        //各リストアイテムの読み込みここまで
        //スイッチが押された際のチェックマークの状態保持
        checkmark.removeAll()
        for _ in 0..<listitems[selectedCell].count {
            checkmark.append(0)
        }
        checkmark1.removeAll()
        for _ in 0..<listitems1[selectedCell].count {
            checkmark1.append(0)
        }
        checkmark2.removeAll()
        for _ in 0..<listitems2[selectedCell].count {
            checkmark2.append(0)
        }
        checkmark3.removeAll()
        for _ in 0..<listitems3[selectedCell].count {
            checkmark3.append(0)
        }
        checkmark4.removeAll()
        for _ in 0..<listitems4[selectedCell].count {
            checkmark4.append(0)
        }
        checkmark5.removeAll()
        for _ in 0..<listitems5[selectedCell].count {
            checkmark5.append(0)
        }
        checkmark6.removeAll()
        for _ in 0..<listitems6[selectedCell].count {
            checkmark6.append(0)
        }
        checkmark7.removeAll()
        for _ in 0..<listitems7[selectedCell].count {
            checkmark7.append(0)
        }
        saveItems3(items: checkmark, key: "udCheckMark")
        saveItems3(items: checkmark1, key: "udCheckMark1")
        saveItems3(items: checkmark2, key: "udCheckMark2")
        saveItems3(items: checkmark3, key: "udCheckMark3")
        saveItems3(items: checkmark4, key: "udCheckMark4")
        saveItems3(items: checkmark5, key: "udCheckMark5")
        saveItems3(items: checkmark6, key: "udCheckMark6")
        saveItems3(items: checkmark7, key: "udCheckMark7")
        //ここまで
        
        //コピー処理記述
        var items = [UIMenuElement]()
        items.append(UIAction(title: "全項目コピー & 新規リスト作成", image: UIImage(systemName: "doc.badge.plus"), handler: { [self] action in
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
            
            if (points[0][selectedCell].dateswitch == false) {
                for i in 0..<listitems[selectedCell].count {
                    listitems[listitems.count - 1].append(listitems[selectedCell][i])
                }
            } else if (points[0][selectedCell].dateswitch == true) {
                for i in 0..<listitems[selectedCell].count {
                    listitems[listitems.count - 1].append(listitems[selectedCell][i])
                }
                for i in 0..<listitems1[selectedCell].count {
                    listitems1[listitems1.count - 1].append(listitems1[selectedCell][i])
                }
                for i in 0..<listitems2[selectedCell].count {
                    listitems2[listitems2.count - 1].append(listitems2[selectedCell][i])
                }
                for i in 0..<listitems3[selectedCell].count {
                    listitems3[listitems3.count - 1].append(listitems3[selectedCell][i])
                }
                for i in 0..<listitems4[selectedCell].count {
                    listitems4[listitems4.count - 1].append(listitems4[selectedCell][i])
                }
                for i in 0..<listitems5[selectedCell].count {
                    listitems5[listitems5.count - 1].append(listitems5[selectedCell][i])
                }
                for i in 0..<listitems6[selectedCell].count {
                    listitems6[listitems6.count - 1].append(listitems6[selectedCell][i])
                }
                for i in 0..<listitems7[selectedCell].count {
                    listitems7[listitems7.count - 1].append(listitems7[selectedCell][i])
                }
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
            if (hukugen.count == items2.count) {
                hukugen.append([String]())
            }
            saveItems(items: hukugen, key: "udHukugen")
            performSegue(withIdentifier: "copySegue", sender: nil)
        }))
        
        items.append(UIAction(title: "コピーした内容をペースト", image: UIImage(systemName: "square.and.pencil"), handler: { [self] action in
            if (copyarray.isEmpty == false && points[0][selectedCell].dateswitch == false) {
                
                if (points[0][selectedCell].dateswitch == false) {
                    for i in 0..<copyarray.count{
                        listitems[selectedCell].append(copyarray[i])
                        checkmark.append(0)
                    }
                    tableview.reloadData()
                    saveItems(items: listitems, key: "udListItem")
                    saveItems3(items: checkmark, key: "udCheckMark")
                }
            }
        }))
        
        items.append(UIAction(title: "チェックした項目をコピー", image: UIImage(systemName: "doc.on.clipboard"), handler: { [self] action in
            copyarray.removeAll()
            if (points[0][selectedCell].dateswitch == false) {
                for i in 0..<checkmark.count {
                    if (checkmark[i] == 1) {
                        copyarray.append(listitems[selectedCell][i])
                        checkmark[i] = 0
                    }
                }
            } else if (points[0][selectedCell].dateswitch == true) {
                for i in 0..<checkmark.count {
                    if (checkmark[i] == 1) {
                        copyarray.append(listitems[selectedCell][i])
                        checkmark[i] = 0
                    }
                }
                for i in 0..<checkmark1.count {
                    if (checkmark1[i] == 1) {
                        copyarray.append(listitems1[selectedCell][i])
                    }
                }
                for i in 0..<checkmark2.count {
                    if (checkmark2[i] == 1) {
                        copyarray.append(listitems2[selectedCell][i])
                    }
                }
                for i in 0..<checkmark3.count {
                    if (checkmark3[i] == 1) {
                        copyarray.append(listitems3[selectedCell][i])
                    }
                }
                for i in 0..<checkmark4.count {
                    if (checkmark4[i] == 1) {
                        copyarray.append(listitems4[selectedCell][i])
                    }
                }
                for i in 0..<checkmark5.count {
                    if (checkmark5[i] == 1) {
                        copyarray.append(listitems5[selectedCell][i])
                    }
                }
                for i in 0..<checkmark6.count {
                    if (checkmark6[i] == 1) {
                        copyarray.append(listitems6[selectedCell][i])
                    }
                }
                for i in 0..<checkmark7.count {
                    if (checkmark7[i] == 1) {
                        copyarray.append(listitems7[selectedCell][i])
                    }
                }
            }
            tableview.reloadData()
            saveItems2(items: copyarray, key: "udCopyArray")
        }))
        
        copyButton.showsMenuAsPrimaryAction = true
        copyButton.menu = UIMenu(title: "", options: .displayInline, children: items)
        //コピー処理ここまで
        
        //削除処理記述
        let destruct = UIMenu(options: .displayInline, children: [
            UIAction(title: "チェック済みの項目を削除", image: UIImage(systemName: "trash"), attributes: .destructive) { [self] action in
                var i = 0
                if (points[0][selectedCell].dateswitch == false) {
                    for _ in 0..<tableview.numberOfRows(inSection: 0){
                        let indexPath = IndexPath(row: i, section: 0)
                        if (checkmark[i] == 1) {
                            historyList[selectedCell].append(listitems[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList, key: "udHistory")
                            listitems[selectedCell].remove(at: indexPath.row)
                            checkmark.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            
                            i = i - 1
                        }
                        i = i + 1
                    }
                } else if (points[0][selectedCell].dateswitch == true) {
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 0){
                        let indexPath = IndexPath(row: i, section: 0)
                        if (checkmark[i] == 1) {
                            historyList[selectedCell].append(listitems[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList, key: "udHistory")
                            listitems[selectedCell].remove(at: indexPath.row)
                            checkmark.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 1){
                        let indexPath = IndexPath(row: i, section: 1)
                        if (checkmark1[i] == 1) {
                            historyList1[selectedCell].append(listitems1[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList1, key: "udHistory1")
                            listitems1[selectedCell].remove(at: indexPath.row)
                            checkmark1.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 2){
                        let indexPath = IndexPath(row: i, section: 2)
                        if (checkmark2[i] == 1) {
                            historyList2[selectedCell].append(listitems2[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList2, key: "udHistory2")
                            listitems2[selectedCell].remove(at: indexPath.row)
                            checkmark2.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 3){
                        let indexPath = IndexPath(row: i, section: 3)
                        if (checkmark3[i] == 1) {
                            historyList3[selectedCell].append(listitems3[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList3, key: "udHistory3")
                            listitems3[selectedCell].remove(at: indexPath.row)
                            checkmark3.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 4){
                        let indexPath = IndexPath(row: i, section: 4)
                        if (checkmark4[i] == 1) {
                            historyList4[selectedCell].append(listitems4[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList5, key: "udHistory4")
                            listitems4[selectedCell].remove(at: indexPath.row)
                            checkmark4.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 5){
                        let indexPath = IndexPath(row: i, section: 5)
                        if (checkmark5[i] == 1) {
                            historyList5[selectedCell].append(listitems6[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList5, key: "udHistory5")
                            listitems5[selectedCell].remove(at: indexPath.row)
                            checkmark5.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 6){
                        let indexPath = IndexPath(row: i, section: 6)
                        if (checkmark6[i] == 1) {
                            historyList6[selectedCell].append(listitems6[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList6, key: "udHistory6")
                            listitems6[selectedCell].remove(at: indexPath.row)
                            checkmark6.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    i = 0
                    for _ in 0..<tableview.numberOfRows(inSection: 7){
                        let indexPath = IndexPath(row: i, section: 7)
                        if (checkmark7[i] == 1) {
                            historyList7[selectedCell].append(listitems7[selectedCell][indexPath.row])
                            //消す前にHistoryListに保存
                            saveItems(items: historyList7, key: "udHistory7")
                            listitems7[selectedCell].remove(at: indexPath.row)
                            checkmark7.remove(at: indexPath.row)
                            tableview.deleteRows(at: [indexPath], with: .automatic)
                            i = i - 1
                        }
                        i = i + 1
                    }
                    
                }
                saveItems(items: listitems, key: "udListItem")
                saveItems(items: listitems1, key: "udListItem1")
                saveItems(items: listitems2, key: "udListItem2")
                saveItems(items: listitems3, key: "udListItem3")
                saveItems(items: listitems4, key: "udListItem4")
                saveItems(items: listitems5, key: "udListItem5")
                saveItems(items: listitems6, key: "udListItem6")
                saveItems(items: listitems7, key: "udListItem7")
                saveItems3(items: checkmark1, key: "udCheckMark1")
                saveItems3(items: checkmark2, key: "udCheckMark2")
                saveItems3(items: checkmark3, key: "udCheckMark3")
                saveItems3(items: checkmark4, key: "udCheckMark4")
                saveItems3(items: checkmark5, key: "udCheckMark5")
                saveItems3(items: checkmark6, key: "udCheckMark6")
                saveItems3(items: checkmark7, key: "udCheckMark7")
            },
            UIAction(title: "全ての項目を削除", image: UIImage(systemName: "trash"), attributes: .destructive) { [self] action in
                let indexPath1 = IndexPath(row: 0, section: 0)
                let indexPath2 = IndexPath(row: 0, section: 1)
                let indexPath3 = IndexPath(row: 0, section: 2)
                let indexPath4 = IndexPath(row: 0, section: 3)
                let indexPath5 = IndexPath(row: 0, section: 4)
                let indexPath6 = IndexPath(row: 0, section: 5)
                let indexPath7 = IndexPath(row: 0, section: 6)
                let indexPath8 = IndexPath(row: 0, section: 7)
                
                if (points[0][selectedCell].dateswitch == false){
                    while(listitems[selectedCell].isEmpty == false){
                        historyList[selectedCell].append(listitems[selectedCell][indexPath1.row])
                        saveItems(items: historyList, key: "udHistory")
                        listitems[selectedCell].remove(at: indexPath1.row)
                        checkmark.remove(at: indexPath1.row)
                        tableview.deleteRows(at: [indexPath1], with: .automatic)
                        saveItems(items: listitems, key: "udListItem")
                        saveItems3(items: checkmark, key: "udCheckMark")
                    }
                } else if (points[0][selectedCell].dateswitch == true){
                    while(listitems1[selectedCell].isEmpty == false || listitems2[selectedCell].isEmpty == false ||
                          listitems3[selectedCell].isEmpty == false || listitems4[selectedCell].isEmpty == false || listitems5[selectedCell].isEmpty == false || listitems6[selectedCell].isEmpty == false || listitems7[selectedCell].isEmpty == false){
                        if (listitems[selectedCell].isEmpty == false){
                            historyList[selectedCell].append(listitems[selectedCell][indexPath1.row])
                            saveItems(items: historyList, key: "udHistory")
                            listitems[selectedCell].remove(at: indexPath1.row)
                            checkmark.remove(at: indexPath1.row)
                            tableview.deleteRows(at: [indexPath1], with: .automatic)
                        }
                        if (listitems1[selectedCell].isEmpty == false){
                            historyList1[selectedCell].append(listitems1[selectedCell][indexPath2.row])
                            saveItems(items: historyList1, key: "udHistory1")
                            listitems1[selectedCell].remove(at: indexPath2.row)
                            checkmark1.remove(at: indexPath2.row)
                            tableview.deleteRows(at: [indexPath2], with: .automatic)
                        }
                        if (listitems2[selectedCell].isEmpty == false){
                            historyList2[selectedCell].append(listitems2[selectedCell][indexPath3.row])
                            saveItems(items: historyList2, key: "udHistory2")
                            listitems2[selectedCell].remove(at: indexPath3.row)
                            checkmark2.remove(at: indexPath3.row)
                            tableview.deleteRows(at: [indexPath3], with: .automatic)
                        }
                        if (listitems3[selectedCell].isEmpty == false){
                            historyList3[selectedCell].append(listitems3[selectedCell][indexPath4.row])
                            saveItems(items: historyList3, key: "udHistory3")
                            listitems3[selectedCell].remove(at: indexPath4.row)
                            checkmark3.remove(at: indexPath4.row)
                            tableview.deleteRows(at: [indexPath4], with: .automatic)
                        }
                        if (listitems4[selectedCell].isEmpty == false){
                            historyList4[selectedCell].append(listitems4[selectedCell][indexPath5.row])
                            saveItems(items: historyList4, key: "udHistory4")
                            listitems4[selectedCell].remove(at: indexPath5.row)
                            checkmark4.remove(at: indexPath5.row)
                            tableview.deleteRows(at: [indexPath5], with: .automatic)
                        }
                        if (listitems5[selectedCell].isEmpty == false){
                            historyList5[selectedCell].append(listitems5[selectedCell][indexPath6.row])
                            saveItems(items: historyList5, key: "udHistory5")
                            listitems5[selectedCell].remove(at: indexPath6.row)
                            checkmark5.remove(at: indexPath6.row)
                            tableview.deleteRows(at: [indexPath6], with: .automatic)
                        }
                        if (listitems6[selectedCell].isEmpty == false){
                            historyList6[selectedCell].append(listitems6[selectedCell][indexPath7.row])
                            saveItems(items: historyList6, key: "udHistory6")
                            listitems6[selectedCell].remove(at: indexPath7.row)
                            checkmark6.remove(at: indexPath7.row)
                            tableview.deleteRows(at: [indexPath7], with: .automatic)
                        }
                        if (listitems7[selectedCell].isEmpty == false){
                            historyList7[selectedCell].append(listitems7[selectedCell][indexPath8.row])
                            saveItems(items: historyList7, key: "udHistory7")
                            listitems7[selectedCell].remove(at: indexPath8.row)
                            checkmark7.remove(at: indexPath8.row)
                            tableview.deleteRows(at: [indexPath8], with: .automatic)
                        }
                        saveItems(items: listitems1, key: "udListItem1")
                        saveItems(items: listitems2, key: "udListItem2")
                        saveItems(items: listitems3, key: "udListItem3")
                        saveItems(items: listitems4, key: "udListItem4")
                        saveItems(items: listitems5, key: "udListItem5")
                        saveItems(items: listitems6, key: "udListItem6")
                        saveItems(items: listitems7, key: "udListItem7")
                        saveItems3(items: checkmark1, key: "udCheckMark1")
                        saveItems3(items: checkmark2, key: "udCheckMark2")
                        saveItems3(items: checkmark3, key: "udCheckMark3")
                        saveItems3(items: checkmark4, key: "udCheckMark4")
                        saveItems3(items: checkmark5, key: "udCheckMark5")
                        saveItems3(items: checkmark6, key: "udCheckMark6")
                        saveItems3(items: checkmark7, key: "udCheckMark7")
                    }
                }
            }
        ])
        deleteButton.menu = UIMenu(title: "", children: [destruct])
        deleteButton.showsMenuAsPrimaryAction = true
        //削除処理ここまで
        //画面表示の際にフッターが表示されないように
        let safeAreaInset2: CGFloat
        safeAreaInset2 = tableview.safeAreaInsets.bottom
        var bottom: CGFloat
        bottom = -(safeAreaInset2 + 50)
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
        //ここまで
        ViewTapped(tapGesture)
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsMultipleSelection = true
    }
    
    //viewDidLoad終了
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        if loadItems(key: "udSwitchArray") != nil {
            switchArray = loadItems(key: "udSwitchArray")!
        }
        if loadItems3(key: "udCheckMark") != nil {
            checkmark = loadItems3(key: "udCheckMark")!
        }
        
        if loadItems2(key: "udCopyArray") != nil {
            copyarray = loadItems2(key: "udCopyArray")!
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
        if loadItems(key: "udHukugen") != nil {
            hukugen = loadItems(key: "udHukugen")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        if loadFlag(key: "udBalloonflag") != nil {
            Balloonflag = loadFlag(key: "udBalloonflag")!
        }
        checkmark.removeAll()
        for _ in 0..<listitems[selectedCell].count {
            checkmark.append(0)
        }
        checkmark1.removeAll()
        for _ in 0..<listitems1[selectedCell].count {
            checkmark1.append(0)
        }
        checkmark2.removeAll()
        for _ in 0..<listitems2[selectedCell].count {
            checkmark2.append(0)
        }
        checkmark3.removeAll()
        for _ in 0..<listitems3[selectedCell].count {
            checkmark3.append(0)
        }
        checkmark4.removeAll()
        for _ in 0..<listitems4[selectedCell].count {
            checkmark4.append(0)
        }
        checkmark5.removeAll()
        for _ in 0..<listitems5[selectedCell].count {
            checkmark5.append(0)
        }
        checkmark6.removeAll()
        for _ in 0..<listitems6[selectedCell].count {
            checkmark6.append(0)
        }
        checkmark7.removeAll()
        for _ in 0..<listitems7[selectedCell].count {
            checkmark7.append(0)
        }
        saveItems3(items: checkmark, key: "udCheckMark")
        saveItems3(items: checkmark1, key: "udCheckMark1")
        saveItems3(items: checkmark2, key: "udCheckMark2")
        saveItems3(items: checkmark3, key: "udCheckMark3")
        saveItems3(items: checkmark4, key: "udCheckMark4")
        saveItems3(items: checkmark5, key: "udCheckMark5")
        saveItems3(items: checkmark6, key: "udCheckMark6")
        saveItems3(items: checkmark7, key: "udCheckMark7")
        tableview.reloadData()
        print("viewcontroller,points\(points)")
    }
    //ViewWillApper終了
    
    //吹き出し処理記述
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        return true
    }
    @IBAction func ViewTapped(_ sender: UITapGestureRecognizer) {
        let titleLabel = UILabel(frame: CGRect(origin: .zero, size: .zero))
        if loadFlag(key: "udBalloonflag") != nil {
            Balloonflag = loadFlag(key: "udBalloonflag")!
        }
        if (Balloonflag == 0) {
            titleLabel.textAlignment = .center
            titleLabel.text = "持ち物ボタンタップで\n簡単にアイテム追加！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .lowerRight)
            Balloonflag = 1
        } else if (Balloonflag == 1) {
            titleLabel.textAlignment = .center
            titleLabel.text = "コピーボタンでチェックを入れた\nアイテムをコピー&ペースト！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .upperRight)
            Balloonflag = 2
        } else if (Balloonflag == 2) {
            titleLabel.textAlignment = .center
            titleLabel.text = "履歴ボタンで削除してしまった\nアイテムの復元ができる！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .up)
            Balloonflag = 3
        } else if (Balloonflag == 3) {
            titleLabel.textAlignment = .center
            titleLabel.text = "削除ボタンでアイテムの\n一括削除が可能！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .upperLeft)
            Balloonflag = 4
        } else if (Balloonflag == 4) {
            titleLabel.textAlignment = .center
            titleLabel.text = "より詳しい使い方を見たい方は\nヘルプボタンをタップ！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .lowerLeft)
            Balloonflag = 5
        } else if (Balloonflag == 5) {
            titleLabel.textAlignment = .center
            titleLabel.text = "end"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .lowerLeft)
        }
        saveFlag(items: Balloonflag, key: "udBalloonflag")
        print(Balloonflag)
    }
    @objc func removeAllBalloonView(sender: UIButton) {
        let targetViews = [mainView]
        targetViews.forEach { (targetView) in
            targetView?.subviews.forEach({ (subView) in
                if subView is BalloonView {
                    UIView.animate(withDuration: 0.3, animations: {
                        subView.alpha = 0
                    }, completion: { (_) in
                        subView.removeFromSuperview()
                    })
                }
            })
        }
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (points[0][selectedCell].dateswitch == false){
            return listitems[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 0){
            return listitems[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 1){
            return listitems1[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 2){
            return listitems2[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 3){
            return listitems3[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 4){
            return listitems4[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 5){
            return listitems5[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 6){
            return listitems6[selectedCell].count
        } else if (points[0][selectedCell].dateswitch == true && section == 7){
            return listitems7[selectedCell].count
        } else {
            return 0
        }
    }
    
    //セクション関連
    func numberOfSections(in tableView: UITableView) -> Int {
        if (points[0][selectedCell].dateswitch == true){
            return section2.count
        } else if (points[0][selectedCell].dateswitch == false) {
            return section1.count
        } else {
            return 0
        }
    }
    
    //ヘッダー関連
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String? {
        if (points[0][selectedCell].dateswitch == true){
            return section2[section] as? String
        } else {
            return section1[section] as? String
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 30))
        if (points[0][selectedCell].dateswitch == true){
            label.text = "  \(section2[section])"
        }
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        label.textColor =  UIColor.black
        if (points[0][selectedCell].dateswitch == true){
            view.addSubview(label)
        }
        return view
    }
    //ヘッダーここまで
    
    //スクロールした際にヘッダー・フッターが残らないように
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let safeAreaInset: CGFloat
        safeAreaInset = scrollView.safeAreaInsets.top
        let top: CGFloat
        if offsetY > 30{
            top = -(safeAreaInset + 30)
        } else if offsetY < -safeAreaInset {
            top = 0
        } else {
            top = -(safeAreaInset + offsetY)
        }
        
        let safeAreaInset2: CGFloat
        safeAreaInset2 = scrollView.safeAreaInsets.bottom
        var bottom: CGFloat
        bottom = -(safeAreaInset2 + 50)
        //一番下に到達した時の処理
        let scroll = scrollView.contentOffset.y + scrollView.frame.size.height + 20
        if scrollView.contentSize.height <= scroll {
            bottom = 0
        }
        scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    //フッター関連
    func tableView(_ tableView:UITableView,titleForFooterInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let button = UIButton(frame: CGRect(x:10, y:5, width:40, height: 40))
        let image = UIImage(systemName: "cross.case.fill")
        button.setTitleColor(UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4), for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4).cgColor
        button.layer.cornerRadius = 5
        button.setImage(image, for: .normal)
        button.tag = section
        
        // タップされたときのaction
        button.addTarget(self,
                         action: #selector(buttonTapped(_:)),
                         for: .touchUpInside)
        view.addSubview(button)
        return view
    }
    
    @objc func buttonTapped(_ sender : UIButton) {
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        let button: UIButton = sender
        nextView.flag2 = selectedCell
        nextView.arrayIndex = button.tag
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 50
    }
    //フッターここまで
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if (points[0][selectedCell].dateswitch == true) {
            return section3
        } else {
            return nil
        }
    }
    
    //tableviewcellに配列の内容を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for:indexPath)
        
        if (points[0][selectedCell].dateswitch == false) {
            let item = listitems[selectedCell][indexPath.row]
            cell.textLabel?.text = item
            if (checkmark[indexPath.row] == 1) {
                cell.accessoryType = .checkmark
            } else if (checkmark[indexPath.row] == 0) {
                cell.accessoryType = .none
            }
        } else if (points[0][selectedCell].dateswitch == true) {
            if (indexPath.section == 0) {
                let item = listitems[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 1) {
                let item = listitems1[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark1[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark1[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 2) {
                let item = listitems2[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark2[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark2[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 3) {
                let item = listitems3[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark3[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark3[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 4) {
                let item = listitems4[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark4[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark4[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 5) {
                let item = listitems5[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark5[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark5[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 6) {
                let item = listitems6[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark6[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark6[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 7) {
                let item = listitems7[selectedCell][indexPath.row]
                cell.textLabel?.text = item
                if (checkmark7[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (checkmark7[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            }
        }
        _ = tableView.indexPathsForSelectedRows
        cell.selectionStyle = .none
        return cell
    }
    
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("enter")
        if (points[0][selectedCell].dateswitch == false) {
            if (checkmark[indexPath.row] == 0) {
                checkmark[indexPath.row] = 1
            } else if (checkmark[indexPath.row] == 1) {
                checkmark[indexPath.row] = 0
            }
            saveItems3(items: checkmark, key: "udCheckMark")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 0) {
            if (checkmark[indexPath.row] == 0) {
                checkmark[indexPath.row] = 1
            } else if (checkmark[indexPath.row] == 1) {
                checkmark[indexPath.row] = 0
            }
            saveItems3(items: checkmark, key: "udCheckMark")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 1) {
            if (checkmark1[indexPath.row] == 0) {
                checkmark1[indexPath.row] = 1
            } else if (checkmark1[indexPath.row] == 1) {
                checkmark1[indexPath.row] = 0
            }
            saveItems3(items: checkmark1, key: "udCheckMark1")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 2) {
            if (checkmark2[indexPath.row] == 0) {
                checkmark2[indexPath.row] = 1
            } else if (checkmark2[indexPath.row] == 1) {
                checkmark2[indexPath.row] = 0
            }
            saveItems3(items: checkmark2, key: "udCheckMark2")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 3) {
            if (checkmark3[indexPath.row] == 0) {
                checkmark3[indexPath.row] = 1
            } else if (checkmark3[indexPath.row] == 1) {
                checkmark3[indexPath.row] = 0
            }
            saveItems3(items: checkmark3, key: "udCheckMark3")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 4) {
            if (checkmark4[indexPath.row] == 0) {
                checkmark4[indexPath.row] = 1
            } else if (checkmark4[indexPath.row] == 1) {
                checkmark4[indexPath.row] = 0
            }
            saveItems3(items: checkmark4, key: "udCheckMark4")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 5) {
            if (checkmark5[indexPath.row] == 0) {
                checkmark5[indexPath.row] = 1
            } else if (checkmark5[indexPath.row] == 1) {
                checkmark5[indexPath.row] = 0
            }
            saveItems3(items: checkmark5, key: "udCheckMark5")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 6) {
            if (checkmark6[indexPath.row] == 0) {
                checkmark6[indexPath.row] = 1
            } else if (checkmark6[indexPath.row] == 1) {
                checkmark6[indexPath.row] = 0
            }
            saveItems3(items: checkmark6, key: "udCheckMark6")
        } else if (points[0][selectedCell].dateswitch == true && indexPath.section == 7) {
            if (checkmark7[indexPath.row] == 0) {
                checkmark7[indexPath.row] = 1
            } else if (checkmark7[indexPath.row] == 1) {
                checkmark7[indexPath.row] = 0
            }
            saveItems3(items: checkmark7, key: "udCheckMark7")
        }
        tableview.reloadData()
    }
    
    //消す処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //historyList[selectedCell].append(listitems[selectedCell][indexPath.row])
        //消す前にHistoryListに保存
        if(points[0][selectedCell].dateswitch == false) {
            historyList[selectedCell].append(listitems[selectedCell][indexPath.row])
            saveItems(items: historyList, key: "udHistory")
            listitems[selectedCell].remove(at: indexPath.row)
            checkmark.remove(at :indexPath.row)
        } else if (points[0][selectedCell].dateswitch == true) {
            if (indexPath.section == 0){
                historyList[selectedCell].append(listitems[selectedCell][indexPath.row])
                saveItems(items: historyList1, key: "udHistory")
                listitems[selectedCell].remove(at: indexPath.row)
                checkmark.remove(at: indexPath.row)
            } else if (indexPath.section == 1) {
                historyList1[selectedCell].append(listitems1[selectedCell][indexPath.row])
                saveItems(items: historyList1, key: "udHistory1")
                listitems1[selectedCell].remove(at: indexPath.row)
                checkmark1.remove(at: indexPath.row)
            } else if (indexPath.section == 2){
                historyList2[selectedCell].append(listitems2[selectedCell][indexPath.row])
                saveItems(items: historyList2, key: "udHistory2")
                listitems2[selectedCell].remove(at: indexPath.row)
                checkmark2.remove(at: indexPath.row)
            } else if (indexPath.section == 3){
                historyList3[selectedCell].append(listitems3[selectedCell][indexPath.row])
                saveItems(items: historyList3, key: "udHistory3")
                listitems3[selectedCell].remove(at: indexPath.row)
                checkmark3.remove(at: indexPath.row)
            } else if (indexPath.section == 4){
                historyList4[selectedCell].append(listitems4[selectedCell][indexPath.row])
                saveItems(items: historyList4, key: "udHistory4")
                listitems4[selectedCell].remove(at: indexPath.row)
                checkmark4.remove(at: indexPath.row)
            } else if (indexPath.section == 5){
                historyList5[selectedCell].append(listitems5[selectedCell][indexPath.row])
                saveItems(items: historyList5, key: "udHistory5")
                listitems5[selectedCell].remove(at: indexPath.row)
                checkmark5.remove(at: indexPath.row)
            } else if (indexPath.section == 6){
                historyList6[selectedCell].append(listitems6[selectedCell][indexPath.row])
                saveItems(items: historyList6, key: "udHistory6")
                listitems6[selectedCell].remove(at: indexPath.row)
                checkmark6.remove(at: indexPath.row)
            } else if (indexPath.section == 7){
                historyList7[selectedCell].append(listitems7[selectedCell][indexPath.row])
                saveItems(items: historyList7, key: "udHistory7")
                listitems7[selectedCell].remove(at: indexPath.row)
                checkmark7.remove(at: indexPath.row)
            }
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        self.saveItems(items: self.listitems, key: "udListItem")
        self.saveItems(items: self.listitems1, key: "udListItem1")
        self.saveItems(items: self.listitems2, key: "udListItem2")
        self.saveItems(items: self.listitems3, key: "udListItem3")
        self.saveItems(items: self.listitems4, key: "udListItem4")
        self.saveItems(items: self.listitems5, key: "udListItem5")
        self.saveItems(items: self.listitems6, key: "udListItem6")
        self.saveItems(items: self.listitems7, key: "udListItem7")
        self.saveItems3(items: self.checkmark, key: "udCheckMark")
        self.saveItems3(items: self.checkmark1, key: "udCheckMark1")
        self.saveItems3(items: self.checkmark2, key: "udCheckMark2")
        self.saveItems3(items: self.checkmark3, key: "udCheckMark3")
        self.saveItems3(items: self.checkmark4, key: "udCheckMark4")
        self.saveItems3(items: self.checkmark5, key: "udCheckMark5")
        self.saveItems3(items: self.checkmark6, key: "udCheckMark6")
        self.saveItems3(items: self.checkmark7, key: "udCheckMark7")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {         //値渡し
        if (segue.identifier == "toHistory") {
            let controller = segue.destination as! HistoryViewController
            controller.flag2 = selectedCell
        } else if (segue.identifier == "copySegue") {
            let controller = segue.destination as! PlusViewController
            saveFlag(items: items2.count, key: "udFlag")
            controller.flag2 = items2.count
        }
    }
    
    
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        _ = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        savePoints(points: points, key: "udPoint")
        print("戻る遷移\(points[0][selectedCell].dateswitch)")
        performSegue(withIdentifier: "exit1", sender: nil)
    }
    
    
    
    func saveItems(items: [[String]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    func saveItems2(items: [String], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    func saveItems3(items: [Int], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func savePoints(points: [[Geof]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points) else {
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
    func loadItems2(key: String) -> [String]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([String].self, from: data)
        else {
            return nil
        }
        return items
    }
    func loadItems3(key: String) -> [Int]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([Int].self, from: data)
        else {
            return nil
        }
        return items
    }
    func loadFlag(key: String) -> Int? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode(Int.self, from: data)
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
}
    

private extension UITapGestureRecognizer {
/// タップした場所にBalloonViewを表示する
    private struct Balloon {
        static var Balloonflag : Int = 0
}
    private struct save {
        static let userDefaults = UserDefaults.standard
    }
/// - Parameters:
///   - color: 吹き出しの色
///   - contentView: 吹き出し内に入れたいView
///   - directionType: 吹き出しを出したい方向
func showBalloonView(color: UIColor, contentView: UIView, directionType: BalloonViewDirectionType) {
    if loadFlag(key: "udBalloonflag2") != nil {
        Balloon.Balloonflag = loadFlag(key: "udBalloonflag2")!
    }
    guard let tappedView = self.view else { return }

    // 吹き出しの表示数はタップしたView内で1つのみとする
    tappedView.subviews.forEach {
        if $0 is BalloonView {
            $0.removeFromSuperview()
        }
    }
    if (Balloon.Balloonflag == 0) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 60, y: 240),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        Balloon.Balloonflag = 1
    } else if (Balloon.Balloonflag == 1) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 90, y: 770),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        Balloon.Balloonflag = 2
    } else if (Balloon.Balloonflag == 2) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 200, y: 770),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        Balloon.Balloonflag = 3
    } else if (Balloon.Balloonflag == 3) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 300, y: 770),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        Balloon.Balloonflag = 4
    } else if (Balloon.Balloonflag == 4) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 300, y: 100),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        Balloon.Balloonflag = 5
    } else if (Balloon.Balloonflag == 5) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 10000, y: 10000),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
    }
    saveFlag(items: Balloon.Balloonflag, key: "udBalloonflag2")
    }
    
    func saveFlag(items: Int, key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        save.userDefaults.set(data, forKey: key)
    }
    func loadFlag(key: String) -> Int? {
        let jsonDecoder = JSONDecoder()
        guard let data = save.userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode(Int.self, from: data)
        else {
            return nil
        }
        return items
    }
}

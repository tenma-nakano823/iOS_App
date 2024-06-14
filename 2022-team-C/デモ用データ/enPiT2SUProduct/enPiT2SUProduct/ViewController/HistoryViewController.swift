//
//  HistoryViewController.swift
//  enPiT2SUProduct
//
//  Created by 熊田隼汰 on 2022/11/30.
//

import UIKit


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet var mainView: UIView!
    
    let userDefaults = UserDefaults.standard
    var flag2 : Int = 0
    
    
    
    var section1:[String] = ["削除したアイテム"]
    var section2:[String] = ["共通","日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
    var section3:[String] = ["日","月","火","水","木","金","土"]
    var flag1 : Int = 0
    var info : Info2!
    var mustitems = [[String]]()
    var listitems = [[String]]()
    var check = [Int]()
    var check1 = [Int]()
    var check2 = [Int]()
    var check3 = [Int]()
    var check4 = [Int]()
    var check5 = [Int]()
    var check6 = [Int]()
    var check7 = [Int]()
//    var selectedCell : Int = 0
    var savePaths = [IndexPath]()
    var i : Int = 0
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
    var hukugen1 = [[String]]()
    var hukugen2 = [[String]]()
    var hukugen3 = [[String]]()
    var hukugen4 = [[String]]()
    var hukugen5 = [[String]]()
    var hukugen6 = [[String]]()
    var hukugen7 = [[String]]()
    var indexPath_section:Int = 0
    var points = [[Geof]]()
    var HistoryBalloonflag : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
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
        if loadItems(key: "udHukugen1") != nil {
            hukugen1 = loadItems(key: "udHukugen1")!
        }
        if loadItems(key: "udHukugen2") != nil {
            hukugen2 = loadItems(key: "udHukugen2")!
        }
        if loadItems(key: "udHukugen3") != nil {
            hukugen3 = loadItems(key: "udHukugen3")!
        }
        if loadItems(key: "udHukugen4") != nil {
            hukugen4 = loadItems(key: "udHukugen4")!
        }
        if loadItems(key: "udHukugen5") != nil {
            hukugen5 = loadItems(key: "udHukugen5")!
        }
        if loadItems(key: "udHukugen6") != nil {
            hukugen6 = loadItems(key: "udHukugen6")!
        }
        if loadItems(key: "udHukugen7") != nil {
            hukugen7 = loadItems(key: "udHukugen7")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadFlag(key: "udHistoryBalloonflag") != nil {
            HistoryBalloonflag = loadFlag(key: "udHistoryBalloonflag")!
        }
        print(points)
        
            check.removeAll()
            for _ in 0..<historyList[flag2].count {
                check.append(0)
            }
                check1.removeAll()
            for _ in 0..<historyList1[flag2].count {
                check1.append(0)
            }
                check2.removeAll()
            for _ in 0..<historyList2[flag2].count {
                check2.append(0)
            }
                check3.removeAll()
            for _ in 0..<historyList3[flag2].count {
                check3.append(0)
            }
                check4.removeAll()
            for _ in 0..<historyList4[flag2].count {
                check4.append(0)
            }
                check5.removeAll()
            for _ in 0..<historyList5[flag2].count {
                check5.append(0)
            }
                check6.removeAll()
            for _ in 0..<historyList6[flag2].count {
                check6.append(0)
            }
                check7.removeAll()
            for _ in 0..<historyList7[flag2].count {
                check7.append(0)
            }
        saveItems3(items: check, key: "udCheck")
        saveItems3(items: check1, key: "udCheck1")
        saveItems3(items: check2, key: "udCheck2")
        saveItems3(items: check3, key: "udCheck3")
        saveItems3(items: check4, key: "udCheck4")
        saveItems3(items: check5, key: "udCheck5")
        saveItems3(items: check6, key: "udCheck6")
        saveItems3(items: check7, key: "udCheck7")
        
        var items = [UIMenuElement]()
          items.append(UIAction(title: "チェック済みの項目を復元", handler: { [self] action in
              if (points[0][flag2].dateswitch == false){
                  
                  var i = 0
                  for _ in 0 ..< self.tableView.numberOfRows(inSection: 0){
                      let indexPath = IndexPath(row: i, section: 0)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          listitems[flag2].append(historyList[flag2][indexPath.row])
                          check.remove(at :indexPath.row)
                          
                          saveItems(items: listitems, key: "udListItem")
                          saveItems3(items: check, key: "udCheck")
                          
                          self.historyList[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList, key: "udHistory")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
              }else if (points[0][flag2].dateswitch == true){
                  if (historyList[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 0){
                          let indexPath = IndexPath(row: i, section: 0)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems[flag2].append(historyList[flag2][indexPath.row])
                              check.remove(at :indexPath.row)
                              
                              saveItems(items: listitems, key: "udListItem")
                              saveItems3(items: check, key: "udCheck")
                              
                              self.historyList[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList, key: "udHistory")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList1[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 1){
                          let indexPath = IndexPath(row: i, section: 1)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems1[flag2].append(historyList1[flag2][indexPath.row])
                              check1.remove(at :indexPath.row)
                              
                              saveItems(items: listitems1, key: "udListItem1")
                              saveItems3(items: check1, key: "udCheck1")
                              
                              self.historyList1[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList1, key: "udHistory1")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList2[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 2){
                          let indexPath = IndexPath(row: i, section: 2)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems2[flag2].append(historyList2[flag2][indexPath.row])
                              check2.remove(at :indexPath.row)
                              
                              saveItems(items: listitems2, key: "udListItem2")
                              saveItems3(items: check2, key: "udCheck2")
                              
                              self.historyList2[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList2, key: "udHistory2")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList3[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 3){
                          let indexPath = IndexPath(row: i, section: 3)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems3[flag2].append(historyList3[flag2][indexPath.row])
                              check3.remove(at :indexPath.row)
                              
                              saveItems(items: listitems3, key: "udListItem3")
                              saveItems3(items: check3, key: "udCheck3")
                              
                              self.historyList3[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList3, key: "udHistory3")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList4[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 4){
                          let indexPath = IndexPath(row: i, section: 4)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems4[flag2].append(historyList4[flag2][indexPath.row])
                              check4.remove(at :indexPath.row)
                              
                              saveItems(items: listitems4, key: "udListItem4")
                              saveItems3(items: check4, key: "udCheck4")
                              
                              self.historyList4[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList4, key: "udHistory4")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList5[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 5){
                          let indexPath = IndexPath(row: i, section: 5)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems5[flag2].append(historyList5[flag2][indexPath.row])
                              check5.remove(at :indexPath.row)
                              
                              saveItems(items: listitems5, key: "udListItem5")
                              saveItems3(items: check5, key: "udCheck5")
                              
                              self.historyList5[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList5, key: "udHistory5")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList6[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 6){
                          let indexPath = IndexPath(row: i, section: 6)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems6[flag2].append(historyList6[flag2][indexPath.row])
                              check6.remove(at :indexPath.row)
                              
                              saveItems(items: listitems6, key: "udListItem6")
                              saveItems3(items: check5, key: "udCheck6")
                              
                              self.historyList6[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList6, key: "udHistory6")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
                  if (historyList7[flag2].isEmpty == false){
                      var i = 0
                      for _ in 0 ..< self.tableView.numberOfRows(inSection: 7){
                          let indexPath = IndexPath(row: i, section: 7)
                          let cell = self.tableView.cellForRow(at: indexPath)
                          if(cell?.accessoryType == .checkmark){
                              listitems7[flag2].append(historyList7[flag2][indexPath.row])
                              check7.remove(at :indexPath.row)
                              
                              saveItems(items: listitems7, key: "udListItem7")
                              saveItems3(items: check7, key: "udCheck7")
                              
                              self.historyList7[self.flag2].remove(at: indexPath.row)
                              self.saveItems(items: self.historyList7, key: "udHistory7")
                              
                              self.tableView.deleteRows(at: [indexPath], with: .automatic)
                              i = i - 1
                          }
                          i = i + 1
                      }
                  }
              }
          }))
          items.append(UIAction(title: "全ての項目を復元", handler: { [self] action in
              if (points[0][flag2].dateswitch == false){
                  while(historyList[flag2].isEmpty == false){
                      let i = 0
                      let indexPath = IndexPath(row: i, section: 0)
                      listitems[flag2].append(historyList[flag2][indexPath.row])
                      check.append(0)
                      self.saveItems(items: listitems, key: "udListItem")
                      self.saveItems3(items: check, key: "udCheck")
                      
                      self.historyList[self.flag2].remove(at: indexPath.row)
                      self.saveItems(items: self.historyList, key: "udHistory")
                      self.tableView.deleteRows(at: [indexPath], with: .automatic)
                  }
              }else if (points[0][flag2].dateswitch == true){
                  while(historyList[flag2].isEmpty == false || historyList1[flag2].isEmpty == false || historyList2[flag2].isEmpty == false ||
                        historyList3[flag2].isEmpty == false || historyList4[flag2].isEmpty == false || historyList5[flag2].isEmpty == false || historyList6[flag2].isEmpty == false || historyList7[flag2].isEmpty == false){
                      if (historyList[flag2].isEmpty == false){
                          let i = 0
                          let indexPath = IndexPath(row: i, section: 0)
                          listitems[flag2].append(historyList[flag2][indexPath.row])
                          check.append(0)
                          self.saveItems(items: listitems, key: "udListItem")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList, key: "udHistory")
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                      }
                      if (historyList1[flag2].isEmpty == false){
                          let i = 0
                          let indexPath1 = IndexPath(row: i, section: 1)
                          listitems1[flag2].append(historyList1[flag2][indexPath1.row])
                          check.append(0)
                          self.saveItems(items: listitems1, key: "udListItem1")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList1[self.flag2].remove(at: indexPath1.row)
                          self.saveItems(items: self.historyList1, key: "udHistory1")
                          self.tableView.deleteRows(at: [indexPath1], with: .automatic)
                      }
                      if (historyList2[flag2].isEmpty == false){
                          let i = 0
                          let indexPath2 = IndexPath(row: i, section: 2)
                          listitems2[flag2].append(historyList2[flag2][indexPath2.row])
                          check.append(0)
                          self.saveItems(items: listitems2, key: "udListItem2")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList2[self.flag2].remove(at: indexPath2.row)
                          self.saveItems(items: self.historyList2, key: "udHistory2")
                          self.tableView.deleteRows(at: [indexPath2], with: .automatic)
                      }
                      if (historyList3[flag2].isEmpty == false){
                          let i = 0
                          let indexPath3 = IndexPath(row: i, section: 3)
                          listitems3[flag2].append(historyList3[flag2][indexPath3.row])
                          check.append(0)
                          self.saveItems(items: listitems3, key: "udListItem3")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList3[self.flag2].remove(at: indexPath3.row)
                          self.saveItems(items: self.historyList3, key: "udHistory3")
                          self.tableView.deleteRows(at: [indexPath3], with: .automatic)
                      }
                      if (historyList4[flag2].isEmpty == false){
                          let i = 0
                          let indexPath4 = IndexPath(row: i, section: 4)
                          listitems4[flag2].append(historyList4[flag2][indexPath4.row])
                          check.append(0)
                          self.saveItems(items: listitems4, key: "udListItem4")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList4[self.flag2].remove(at: indexPath4.row)
                          self.saveItems(items: self.historyList4, key: "udHistory4")
                          self.tableView.deleteRows(at: [indexPath4], with: .automatic)
                      }
                      if (historyList5[flag2].isEmpty == false){
                          let i = 0
                          let indexPath5 = IndexPath(row: i, section: 5)
                          listitems5[flag2].append(historyList5[flag2][indexPath5.row])
                          check.append(0)
                          self.saveItems(items: listitems5, key: "udListItem5")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList5[self.flag2].remove(at: indexPath5.row)
                          self.saveItems(items: self.historyList5, key: "udHistory5")
                          self.tableView.deleteRows(at: [indexPath5], with: .automatic)
                      }
                      if (historyList6[flag2].isEmpty == false){
                          let i = 0
                          let indexPath6 = IndexPath(row: i, section: 6)
                          listitems6[flag2].append(historyList6[flag2][indexPath6.row])
                          check.append(0)
                          self.saveItems(items: listitems6, key: "udListItem6")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList[self.flag2].remove(at: indexPath6.row)
                          self.saveItems(items: self.historyList6, key: "udHistory6")
                          self.tableView.deleteRows(at: [indexPath6], with: .automatic)
                      }
                      if (historyList7[flag2].isEmpty == false){
                          let i = 0
                          let indexPath7 = IndexPath(row: i, section: 7)
                          listitems7[flag2].append(historyList7[flag2][indexPath7.row])
                          check.append(0)
                          self.saveItems(items: listitems7, key: "udListItem7")
                          self.saveItems3(items: check, key: "udCheck")
                          
                          self.historyList[self.flag2].remove(at: indexPath7.row)
                          self.saveItems(items: self.historyList7, key: "udHistory7")
                          self.tableView.deleteRows(at: [indexPath7], with: .automatic)
                      }
                      
                  }
              }
          }))
          restoreButton.showsMenuAsPrimaryAction = true
          restoreButton.menu = UIMenu(title: "", options: .displayInline, children: items)
          
          
          
          //削除処理記述
          let destruct = UIMenu(options: .displayInline, children: [
              UIAction(title: "チェック済みの項目を削除", image: UIImage(systemName: "trash"), attributes: .destructive) { [self] action in
                  var i = 0
                  if (points[0][flag2].dateswitch == false){
                  for _ in 0..<self.tableView.numberOfRows(inSection: 0){
                      let indexPath = IndexPath(row: i, section: 0)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList, key: "udHistory")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
              } else if (points[0][flag2].dateswitch == true) {
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 0){
                      let indexPath = IndexPath(row: i, section: 0)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList, key: "udHistory")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 1){
                      let indexPath = IndexPath(row: i, section: 1)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList1[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList1, key: "udHistory1")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 2){
                      let indexPath = IndexPath(row: i, section: 2)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList2[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList2, key: "udHistory2")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 3){
                      let indexPath = IndexPath(row: i, section: 3)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList3[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList3, key: "udHistory3")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 4){
                      let indexPath = IndexPath(row: i, section: 4)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList4[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList4, key: "udHistory4")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 5){
                      let indexPath = IndexPath(row: i, section: 5)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList5[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList5, key: "udHistory5")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 6){
                      let indexPath = IndexPath(row: i, section: 6)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList6[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList6, key: "udHistory6")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
                  i = 0
                  for _ in 0..<self.tableView.numberOfRows(inSection: 7){
                      let indexPath = IndexPath(row: i, section: 7)
                      let cell = self.tableView.cellForRow(at: indexPath)
                      if(cell?.accessoryType == .checkmark){
                          self.historyList7[self.flag2].remove(at: indexPath.row)
                          self.saveItems(items: self.historyList7, key: "udHistory7")
                          
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          i = i - 1
                      }
                      i = i + 1
                  }
              }
              saveItems3(items: check, key: "udCheck")
              saveItems3(items: check1, key: "udCheck1")
              saveItems3(items: check2, key: "udCheck2")
              saveItems3(items: check3, key: "udCheck3")
              saveItems3(items: check4, key: "udCheck4")
              saveItems3(items: check5, key: "udCheck5")
              saveItems3(items: check6, key: "udCheck6")
              saveItems3(items: check7, key: "udCheck7")
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
                  
                  if (points[0][flag2].dateswitch == false){
                      while(historyList[flag2].isEmpty == false){
                          historyList[flag2].remove(at: indexPath1.row)
                          saveItems(items: historyList, key: "udHistory")
                          tableView.deleteRows(at: [indexPath1], with: .automatic)
                      }
                  }else if (points[0][flag2].dateswitch == true){
                      while(historyList[flag2].isEmpty == false || historyList1[flag2].isEmpty == false || historyList2[flag2].isEmpty == false ||
                            historyList3[flag2].isEmpty == false || historyList4[flag2].isEmpty == false || historyList5[flag2].isEmpty == false || historyList6[flag2].isEmpty == false || historyList7[flag2].isEmpty == false){
                          if (historyList[flag2].isEmpty == false){
                              historyList[flag2].remove(at: indexPath1.row)
                              saveItems(items: historyList, key: "udHistory")
                              tableView.deleteRows(at: [indexPath1], with: .automatic)
                          }
                          if (historyList1[flag2].isEmpty == false){
                              historyList1[flag2].remove(at: indexPath2.row)
                              saveItems(items: historyList1, key: "udHistory1")
                              tableView.deleteRows(at: [indexPath2], with: .automatic)
                          }
                          if (historyList2[flag2].isEmpty == false){
                              historyList2[flag2].remove(at: indexPath3.row)
                              saveItems(items: historyList2, key: "udHistory2")
                              tableView.deleteRows(at: [indexPath3], with: .automatic)
                          }
                          if (historyList3[flag2].isEmpty == false){
                              historyList3[flag2].remove(at: indexPath4.row)
                              saveItems(items: historyList3, key: "udHistory3")
                              tableView.deleteRows(at: [indexPath4], with: .automatic)
                          }
                          if (historyList4[flag2].isEmpty == false){
                              historyList4[flag2].remove(at: indexPath5.row)
                              saveItems(items: historyList4, key: "udHistory4")
                              tableView.deleteRows(at: [indexPath5], with: .automatic)
                          }
                          if (historyList5[flag2].isEmpty == false){
                              historyList5[flag2].remove(at: indexPath6.row)
                              saveItems(items: historyList5, key: "udHistory5")
                              tableView.deleteRows(at: [indexPath6], with: .automatic)
                          }
                          if (historyList6[flag2].isEmpty == false){
                              historyList6[flag2].remove(at: indexPath7.row)
                              saveItems(items: historyList6, key: "udHistory6")
                              tableView.deleteRows(at: [indexPath7], with: .automatic)
                          }
                          if (historyList7[flag2].isEmpty == false){
                              historyList7[flag2].remove(at: indexPath8.row)
                              saveItems(items: historyList7, key: "udHistory7")
                              tableView.deleteRows(at: [indexPath8], with: .automatic)
                          }
                      }
                  }
              }
              ])
          deleteButton.menu = UIMenu(title: "", children: [destruct])
          deleteButton.showsMenuAsPrimaryAction = true
        
        //viewTapped(tapGesture)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        
        
        if loadItems3(key: "udCheck") != nil {
            check = loadItems3(key: "udCheck")!
        }
        
        print(check)
        print(listitems)
        
        
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        hukugen.removeAll()
        hukugen1.removeAll()
        hukugen2.removeAll()
        hukugen3.removeAll()
        hukugen4.removeAll()
        hukugen5.removeAll()
        hukugen6.removeAll()
        hukugen7.removeAll()
        
        
        saveItems(items: hukugen, key: "udHukugen")
        saveItems(items: hukugen1, key: "udHukugen1")
        saveItems(items: hukugen2, key: "udHukugen2")
        saveItems(items: hukugen3, key: "udHukugen3")
        saveItems(items: hukugen4, key: "udHukugen4")
        saveItems(items: hukugen5, key: "udHukugen5")
        saveItems(items: hukugen6, key: "udHukugen6")
        saveItems(items: hukugen7, key: "udHukugen7")
        
        
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
            check = loadItems3(key: "udCheck")!
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
        if loadItems(key: "udHukugen1") != nil {
            hukugen1 = loadItems(key: "udHukugen1")!
        }
        if loadItems(key: "udHukugen2") != nil {
            hukugen2 = loadItems(key: "udHukugen2")!
        }
        if loadItems(key: "udHukugen3") != nil {
            hukugen3 = loadItems(key: "udHukugen3")!
        }
        if loadItems(key: "udHukugen4") != nil {
            hukugen4 = loadItems(key: "udHukugen4")!
        }
        if loadItems(key: "udHukugen5") != nil {
            hukugen5 = loadItems(key: "udHukugen5")!
        }
        if loadItems(key: "udHukugen6") != nil {
            hukugen6 = loadItems(key: "udHukugen6")!
        }
        if loadItems(key: "udHukugen7") != nil {
            hukugen7 = loadItems(key: "udHukugen7")!
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        print(check)
        
        check.removeAll()
        for _ in 0..<historyList[flag2].count {
            check.append(0)
        }
            check1.removeAll()
        for _ in 0..<historyList1[flag2].count {
            check1.append(0)
        }
            check2.removeAll()
        for _ in 0..<historyList2[flag2].count {
            check2.append(0)
        }
            check3.removeAll()
        for _ in 0..<historyList3[flag2].count {
            check3.append(0)
        }
            check4.removeAll()
        for _ in 0..<historyList4[flag2].count {
            check4.append(0)
        }
            check5.removeAll()
        for _ in 0..<historyList5[flag2].count {
            check5.append(0)
        }
            check6.removeAll()
        for _ in 0..<historyList6[flag2].count {
            check6.append(0)
        }
            check7.removeAll()
        for _ in 0..<historyList7[flag2].count {
            check7.append(0)
        }
        saveItems3(items: check, key: "udCheck")
        saveItems3(items: check1, key: "udCheck1")
        saveItems3(items: check2, key: "udCheck2")
        saveItems3(items: check3, key: "udCheck3")
        saveItems3(items: check4, key: "udCheck4")
        saveItems3(items: check5, key: "udCheck5")
        saveItems3(items: check6, key: "udCheck6")
        saveItems3(items: check7, key: "udCheck7")
        
        
        tableView.reloadData()
      
    }
    
    /*@IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        let titleLabel = UILabel(frame: CGRect(origin: .zero, size: .zero))
        if loadFlag(key: "udHistoryBalloonflag") != nil {
            HistoryBalloonflag = loadFlag(key: "udHistoryBalloonflag")!
        }
        if (HistoryBalloonflag == 0) {
            titleLabel.textAlignment = .center
            titleLabel.text = "持ち物ボタンタップで\n簡単にアイテム追加！"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .lowerRight)
            HistoryBalloonflag = 1
        } else if (HistoryBalloonflag == 1) {
            titleLabel.textAlignment = .center
            titleLabel.text = "end"
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.sizeToFit()
            let ballooncolor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
            sender.showBalloonView(color: ballooncolor, contentView: titleLabel, directionType: .lowerLeft)
        }
    }*/
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (points[0][flag2].dateswitch == false){      
            return historyList[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 0){
            return historyList[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 1){
            return historyList1[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 2){
            return historyList2[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 3){
            return historyList3[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 4){
            return historyList4[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 5){
            return historyList5[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 6){
            return historyList6[flag2].count
        } else if (points[0][flag2].dateswitch == true && section == 7){
            return historyList7[flag2].count
        } else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (points[0][flag2].dateswitch == true){
            return section2.count
        } else if (points[0][flag2].dateswitch == false) {
            return section1.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String? {
        if (points[0][flag2].dateswitch == true ){
            return section2[section]
        } else {
            return section1[section]
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 30))
        if (points[0][flag2].dateswitch == true){
            label.text = "  \(section2[section])"
        }
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        label.textColor =  UIColor.black
        if (points[0][flag2].dateswitch == true){
            view.addSubview(label)
        }
        return view
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if (points[0][flag2].dateswitch == true) {
            return section3
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for:indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if (points[0][flag2].dateswitch == false) {
            let item = historyList[flag2][indexPath.row]
            cell.textLabel?.text = item
            if (check[indexPath.row] == 1) {
                cell.accessoryType = .checkmark
            } else if (check[indexPath.row] == 0) {
                cell.accessoryType = .none
            }
        } else if (points[0][flag2].dateswitch == true) {
            if (indexPath.section == 0) {
                let item = historyList[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 1) {
                let item = historyList1[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check1[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check1[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 2) {
                let item = historyList2[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check2[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check2[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 3) {
                let item = historyList3[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check3[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check3[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 4) {
                let item = historyList4[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check4[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check4[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 5) {
                let item = historyList5[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check5[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check5[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
            } else if (indexPath.section == 6) {
                let item = historyList6[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check6[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check6[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
                }
            else if (indexPath.section == 7) {
                let item = historyList7[flag2][indexPath.row]
                cell.textLabel?.text = item
                if (check7[indexPath.row] == 1) {
                    cell.accessoryType = .checkmark
                } else if (check7[indexPath.row] == 0) {
                    cell.accessoryType = .none
                }
                }
        }
        _ = tableView.indexPathsForSelectedRows
        return cell
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (points[0][flag2].dateswitch == false) {
            if (check[indexPath.row] == 0) {
                check[indexPath.row] = 1
            } else if (check[indexPath.row] == 1) {
                check[indexPath.row] = 0
            }
            saveItems3(items: check, key: "udCheck")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 0) {
            if (check[indexPath.row] == 0) {
                check[indexPath.row] = 1
            } else if (check[indexPath.row] == 1) {
                check[indexPath.row] = 0
            }
            saveItems3(items: check1, key: "udCheck")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 1) {
            if (check1[indexPath.row] == 0) {
                check1[indexPath.row] = 1
            } else if (check1[indexPath.row] == 1) {
                check1[indexPath.row] = 0
            }
            saveItems3(items: check, key: "udCheck1")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 2) {
            if (check2[indexPath.row] == 0) {
                check2[indexPath.row] = 1
            } else if (check[indexPath.row] == 1) {
                check2[indexPath.row] = 0
            }
            saveItems3(items: check2, key: "udCheck2")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 3) {
            if (check3[indexPath.row] == 0) {
                check3[indexPath.row] = 1
            } else if (check3[indexPath.row] == 1) {
                check3[indexPath.row] = 0
            }
            saveItems3(items: check3, key: "udCheck3")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 4) {
            if (check4[indexPath.row] == 0) {
                check4[indexPath.row] = 1
            } else if (check4[indexPath.row] == 1) {
                check4[indexPath.row] = 0
            }
            saveItems3(items: check4, key: "udCheck4")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 5) {
            if (check5[indexPath.row] == 0) {
                check5[indexPath.row] = 1
            } else if (check5[indexPath.row] == 1) {
                check5[indexPath.row] = 0
            }
            saveItems3(items: check5, key: "udCheck5")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 6) {
            if (check6[indexPath.row] == 0) {
                check6[indexPath.row] = 1
            } else if (check6[indexPath.row] == 1) {
                check6[indexPath.row] = 0
            }
            saveItems3(items: check6, key: "udCheck6")
        } else if (points[0][flag2].dateswitch == true && indexPath.section == 7) {
            if (check7[indexPath.row] == 0) {
                check7[indexPath.row] = 1
            } else if (check7[indexPath.row] == 1) {
                check7[indexPath.row] = 0
            }
            saveItems3(items: check7, key: "udCheck7")
        }
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //消す処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        

            
            if(points[0][flag2].dateswitch == false) {
                historyList[flag2].remove(at: indexPath.row)
                saveItems(items: historyList, key: "udHistory")
            } else if (points[0][flag2].dateswitch == true) {
                if (indexPath.section == 0){
                    historyList[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList, key: "udHistory")
                } else if (indexPath.section == 1){
                    historyList1[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList1, key: "udHistory1")
                } else if (indexPath.section == 2) {
                    historyList2[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList2, key: "udHistory2")
                } else if (indexPath.section == 3){
                    historyList3[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList3, key: "udHistory3")
                } else if (indexPath.section == 4){
                    historyList4[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList4, key: "udHistory4")
                } else if (indexPath.section == 5){
                    historyList5[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList5, key: "udHistory5")
                } else if (indexPath.section == 6){
                    historyList6[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList6, key: "udHistory6")
                } else if (indexPath.section == 7){
                    historyList7[flag2].remove(at: indexPath.row)
                    saveItems(items: historyList7, key: "udHistory7")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    
    // セルが選択された時に呼び出される
 /*   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at:indexPath)?.accessoryType = .checkmark
    }
  */
  
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at:indexPath)?.accessoryType = .none
    }
    
    func saveItems(items: [[String]], key: String) {
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
    func loadItems3(key: String) -> [Int]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode([Int].self, from: data)
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
    func loadFlag(key: String) -> Int? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let items = try? jsonDecoder.decode(Int.self, from: data)
        else {
            return nil
        }
        return items
    }
}

private extension UITapGestureRecognizer {
/// タップした場所にBalloonViewを表示する
    private struct HistoryBalloon {
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
    if loadFlag(key: "udHistoryBalloonflag2") != nil {
        HistoryBalloon.Balloonflag = loadFlag(key: "udHistoryBalloonflag2")!
    }
    guard let tappedView = self.view else { return }

    // 吹き出しの表示数はタップしたView内で1つのみとする
    tappedView.subviews.forEach {
        if $0 is BalloonView {
            $0.removeFromSuperview()
        }
    }
    if (HistoryBalloon.Balloonflag == 0) {
        let balloonView = BalloonView(focusPoint: CGPoint(x: 60, y: 240),
                                      contentView: contentView,
                                      color: color,
                                      directionType: directionType)
        balloonView.alpha = 0
        tappedView.addSubview(balloonView)

        UIView.animate(withDuration: 0.3) {
            balloonView.alpha = 1.0
        }
        HistoryBalloon.Balloonflag = 1
    } else if (HistoryBalloon.Balloonflag == 1) {
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
    saveFlag(items: HistoryBalloon.Balloonflag, key: "udHistoryBalloonflag2")
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


//
//  CategoryScrollContentsViewController.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2022/12/30.
//

import UIKit

class CategoryScrollContentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listitems = [[String]]()
    var listitems1 = [[String]]()
    var listitems2 = [[String]]()
    var listitems3 = [[String]]()
    var listitems4 = [[String]]()
    var listitems5 = [[String]]()
    var listitems6 = [[String]]()
    var listitems7 = [[String]]()
    
    var points = [[Geof]]()
    var addItems : [[String]] = [
        [],[],[],[],[],[],[],[],[]
    ]
    
    var added: Bool = false
    var flag2: Int = 0
    var arrayIndex: Int = 0
    let userDefaults = UserDefaults.standard
    
    let sectionTitle: NSArray = ["テンプレート","追加した項目"]
    
    // 持ち物の一覧データ
    private let itemList: [[String]] = ArticleMock.getArticleItems()
    
    private var articlesByCategoryId: [ArticleEntity]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryScrollContentsTableView()
        
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
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadItems(key: "udAddItem") != nil {
            addItems = loadItems(key: "udAddItem")!
        }
        let Nib = UINib(nibName: "ContentsTableViewCell", bundle: Bundle.main)
        tableView.register(Nib, forCellReuseIdentifier: "ContentsCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if loadItems(key: "udAddItem") != nil {
            addItems = loadItems(key: "udAddItem")!
        }
    }
    
    @IBAction func AddButtonTapped(_ sender: UIButton) {
        var alerttextField: UITextField?
        let alert = UIAlertController(title: "アイテムを追加", message: nil,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                alerttextField = textField
            })
        alert.addAction(UIAlertAction(title: "キャンセル",
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "追加",
                                      style: UIAlertAction.Style.default) { [self] _ in
            let text = alerttextField?.text
            addItems[view.tag].append(text!)
            saveItems(items: addItems, key: "udAddItem")
            tableView.reloadData()
        }
        )
        self.present(alert, animated: true , completion: nil)
    }
    
    private func setupCategoryScrollContentsTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func saveItems(items: [[String]], key: String) {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }

    // 配置するセルの個数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemList[view.tag].count
        }
        else if section == 1 {
            return addItems[view.tag].count
        }
        else {
            return 0
        }
    }

    // 配置するセルの表示内容を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            cell.textLabel?.text = itemList[view.tag][indexPath.row]
            return cell
            
        case 1:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsTableViewCell
            cell1.label.text = addItems[view.tag][indexPath.row]
            cell1.tag = indexPath.row
            cell1.delegate = self
            return cell1
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if (points[0][flag2].dateswitch == false){
                listitems[flag2].append(itemList[view.tag][indexPath.row])
                saveItems(items: listitems, key: "udListItem")
            }
            else if (points[0][flag2].dateswitch == true){
                if (arrayIndex == 0){
                    listitems[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems, key: "udListItem")
                }
                else if (arrayIndex == 1){
                    listitems1[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems1, key: "udListItem1")
                }
                else if (arrayIndex == 2){
                    listitems2[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems2, key: "udListItem2")
                }
                else if (arrayIndex == 3){
                    listitems3[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems3, key: "udListItem3")
                }
                else if (arrayIndex == 4){
                    listitems4[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems4, key: "udListItem4")
                }
                else if (arrayIndex == 5){
                    listitems5[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems5, key: "udListItem5")
                }
                else if (arrayIndex == 6){
                    listitems6[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems6, key: "udListItem6")
                }
                else if (arrayIndex == 7){
                    listitems7[flag2].append(itemList[view.tag][indexPath.row])
                    saveItems(items: listitems7, key: "udListItem7")
                }
            }
        }
        else if indexPath.section == 1 {
            if (points[0][flag2].dateswitch == false){
                listitems[flag2].append(addItems[view.tag][indexPath.row])
                saveItems(items: listitems, key: "udListItem")
            }
            else if (points[0][flag2].dateswitch == true){
                if (arrayIndex == 0){
                    listitems[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems, key: "udListItem")
                }
                else if (arrayIndex == 1){
                    listitems1[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems1, key: "udListItem1")
                }
                else if (arrayIndex == 2){
                    listitems2[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems2, key: "udListItem2")
                }
                else if (arrayIndex == 3){
                    listitems3[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems3, key: "udListItem3")
                }
                else if (arrayIndex == 4){
                    listitems4[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems4, key: "udListItem4")
                }
                else if (arrayIndex == 5){
                    listitems5[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems5, key: "udListItem5")
                }
                else if (arrayIndex == 6){
                    listitems6[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems6, key: "udListItem6")
                }
                else if (arrayIndex == 7){
                    listitems7[flag2].append(addItems[view.tag][indexPath.row])
                    saveItems(items: listitems7, key: "udListItem7")
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension CategoryScrollContentsViewController: CustomCellDelegate {
    
    func customCellDelegateDidTapButton(cell: UITableViewCell) {
        if loadItems(key: "udAddItem") != nil {
            addItems = loadItems(key: "udAddItem")!
        }
        let indexPath = IndexPath(row: cell.tag, section: 1)
        addItems[view.tag].remove(at: cell.tag)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
        saveItems(items: addItems, key: "udAddItem")
    }
}


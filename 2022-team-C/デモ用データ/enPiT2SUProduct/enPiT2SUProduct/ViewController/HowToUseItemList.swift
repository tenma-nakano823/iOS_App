//
//  HowToUseItemList.swift
//  enPiT2SUProduct
//
//  Created by 益子　陸 on 2022/12/26.
//

import UIKit

struct HelpInfo {
    var name: String
    var description: String
    var description2: String
}

class HowToUseItemList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let userDefaults = UserDefaults.standard
    var Balloonflag : Int = 0
    private struct Balloon {
        static var Balloonflag : Int = 0
    }
    
    var sections:[String] = ["使い方", "設定"]
    var helpList = [HelpInfo(name: "新規アイテムの追加", description: "アイテムリストに表示されている上記のボタンを\nタップすると、アイテム追加画面に遷移します。\nその後、アイテム遷移画面にて追加したいアイテム\nを選択することでリストにアイテムを追加すること\nができます。\n\nまた、アプリ側で事前に用意されているアイテム\n以外のものを追加したいときは、各項目の下方に\nある「アイテムを追加」ボタンをタップすることで\n任意のアイテムを追加することができます。", description2: ""), HelpInfo(name: "アイテムの削除", description: "リストに追加したアイテムの削除は、アイテムを\nスワイプすることで行うことができます。\nまた、上記のボタンをタップすると以下二つの操作\nが行えます。\n\n①全ての項目を削除する\n表示されているリスト内のアイテムを\n全て削除することができます。\n\n②チェック済みの項目を削除する\nチェック済みの項目を一括で削除する\nことができます。", description2: ""), HelpInfo(name: "アイテムのチェック", description: "リスト内のアイテムをタップすることで、チェック\nマークをつけることができます。\nチェックマークは、持ち物を準備する際のチェック\nとして使用したり、他のさまざまな操作に活用した\nりすることができます。", description2: ""), HelpInfo(name: "アイテムのコピー", description: "上記ボタンをタップすることで、以下三つの操作\nが行えます。\n\n①チェックした項目をコピー\nチェックを入れた項目を一括でコピーすることが\nできます。\n\n②コピーした内容をペースト\n①のボタンでコピーした内容をリストに貼り付ける\nことができます。他のリストでコピーした内容も貼\nり付けることもできるため、\n類似のリストを作りたいときや同じアイテムを複数\nのリストに追加したいときに活用することができま\nす。\n\n③全項目コピー＆新規リスト作成\n表示されている項目全てをコピーして新しいリスト\nを作成します。全く同じリストが瞬時にできるため、\n類似のリストを作りたいときに活用することができ\nます。また、表示されているリストと曜日設定の\non,offが異なるリストを作成しようとした場合には\n以下のような操作が行われます。", description2: "・曜日設定offのリストからonのリストを作成する\n場合\nリストの内容が、共通の部分にコピーされます。\n曜日別の部分にコピーすることは出来ません。\n\n・曜日設定onのリストからoffのリストを作成する\n場合\n共通部分のアイテムがリストにコピーされます。\n曜日別の部分のアイテムをコピーすることは出来ま\nせん。"), HelpInfo(name: "履歴ボタン", description: "履歴ボタンをタップすることで、削除した項目を\n参照することができます。また、下方にある復元\nボタンで削除した項目の復元や、削除ボタンで最\n近削除した項目から、アイテムを削除することが\nできます。", description2: "")]
    var footerItem :[String] = ["","アプリを入れた際に表示されるユーザーガイドをもう一度表示します\n \n  ※持ち物リスト画面に戻って一度画面をタップするか、\n   他の画面に移ってもう一度持ち物リスト画面を開くと表示されます。"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0.45, green: 0.45, blue: 0.5, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 24.0/255.0, green: 225.0/255.0, blue: 144.0/255.0, alpha:1)
       
        navigationItem.title = "ヘルプ"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            let controller = segue.destination as! HelpDiscription
            controller.info = helpList[selectedRow.row]
            controller.selectedCell = selectedRow.row
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return helpList.count
        } else if (section == 1){
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String? {
            return sections[section] as? String
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x:5, y:0, width: tableView.bounds.width, height: 100))
        label.numberOfLines = 0
        label.text = "  \(footerItem[section])"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.italicSystemFont(ofSize: 13)
        label.textColor =  UIColor.systemGray2
        view.addSubview(label)
        
        return view
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpcell", for:indexPath)
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "userguidecell", for:indexPath) as! UserGuideCell
        if (indexPath.section == 0) {
            let item = helpList[indexPath.row]
            cell.textLabel?.text = item.name
            if (indexPath.row == 0) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            if (indexPath.row == helpList.count - 1) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 10000)
            }
            if indexPath.row == 0{
                let separatorView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
                separatorView.backgroundColor = UIColor(red: 0.39, green: 0.9, blue: 0.89, alpha: 1.0)
                cell.addSubview(separatorView)
            }
            tableView.backgroundColor = UIColor(red: 0.45, green: 0.45, blue: 0.5, alpha: 0.08)
            return cell
        } else if (indexPath.section == 1) {
            cell2.delegate = self
            if (indexPath.row == 0) {
                cell2.layer.cornerRadius = 15
                cell2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell2.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 10000)
                let separatorView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
                separatorView.backgroundColor = UIColor(red: 0.39, green: 0.9, blue: 0.89, alpha: 1.0)
                cell2.addSubview(separatorView)
            }
            tableView.backgroundColor = UIColor(red: 0.45, green: 0.45, blue: 0.5, alpha: 0.08)
            cell2.selectionStyle = .none
            return cell2
        } else {
            return cell
        }
    }
    
    // Cell が選択された場合
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        if loadFlag(key: "udBalloonflag") != nil {
            Balloonflag = loadFlag(key: "udBalloonflag")!
        }
        if loadFlag(key: "udBalloonflag2") != nil {
            Balloon.Balloonflag = loadFlag(key: "udBalloonflag2")!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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

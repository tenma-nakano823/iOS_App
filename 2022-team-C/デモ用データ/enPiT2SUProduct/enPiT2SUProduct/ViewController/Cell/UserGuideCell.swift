//
//  UserGuideCell.swift
//  enPiT2SUProduct
//
//  Created by 益子　陸 on 2023/01/01.
//

import UIKit

class UserGuideCell: UITableViewCell {

    @IBOutlet weak var guideButton: UIButton!
    var delegate: UIViewController?
    var alert:UIAlertController!
        
    let userDefaults = UserDefaults.standard
    var Balloonflag : Int = 0
    private struct Balloon {
        static var Balloonflag : Int = 0
    }
    var HistoryBalloonflag : Int = 0
    private struct HistoryBalloon {
        static var Balloonflag : Int = 0
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if loadFlag(key: "udBalloonflag") != nil {
            Balloonflag = loadFlag(key: "udBalloonflag")!
        }
        if loadFlag(key: "udBalloonflag2") != nil {
            Balloon.Balloonflag = loadFlag(key: "udBalloonflag2")!
        }
        if loadFlag(key: "udHistoryBalloonflag") != nil {
            HistoryBalloonflag = loadFlag(key: "udHistoryBalloonflag")!
        }
        if loadFlag(key: "udHistoryBalloonflag2") != nil {
            HistoryBalloon.Balloonflag = loadFlag(key: "udHistoryBalloonflag2")!
        }
    }

    
    @IBAction func buttonTapped(_ sender: Any) {
        showAlert()
    }
    
    func showAlert(){
        alert = UIAlertController(title:"ユーザーガイドの再表示を行いますか？", message: "", preferredStyle: UIAlertController.Style.alert)
        let action:UIAlertAction = UIAlertAction(title: "はい",
                                                 style: UIAlertAction.Style.default,
                                                           handler:{
                                                            (action:UIAlertAction!) -> Void in
            self.Balloonflag = 0
            Balloon.Balloonflag = 0
            self.HistoryBalloonflag = 0
            HistoryBalloon.Balloonflag = 0
            self.saveFlag(items: self.Balloonflag, key: "udBalloonflag")
            self.saveFlag(items: Balloon.Balloonflag, key: "udBalloonflag2")
            self.saveFlag(items: self.HistoryBalloonflag, key: "udHistoryBalloonflag")
            self.saveFlag(items: HistoryBalloon.Balloonflag, key: "udHistoryBalloonflag2")
                })
        let cancel:UIAlertAction = UIAlertAction(title: "キャンセル",style: UIAlertAction.Style.cancel,
                                                           handler:{
                                                            action in
            })
            alert.addAction(action)
            alert.addAction(cancel)
        delegate!.present(alert, animated: true, completion: nil)
        }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    func saveFlag(items: Int, key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(items)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
    }

}

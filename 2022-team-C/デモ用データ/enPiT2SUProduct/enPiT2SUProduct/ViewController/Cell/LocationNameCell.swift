//
//  LocationNameCell.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/28.
//

import UIKit

class LocationNameCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var locationnameTextfield: UITextField!
    
    var userDefaults = UserDefaults.standard
    
    var points = [[Geof]]()
    var items2 = [Info2]()
    var flag2: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        locationnameTextfield.delegate = self
        locationnameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        locationnameTextfield.endEditing(true)
        //savePoints(points: points, key: "udPoint")
        //print("画面外タップテキスト\(points[0][flag2].locationname)")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        points[0][flag2].locationname = locationnameTextfield.text!
        if (items2.count != flag2) {
            items2[flag2].location = locationnameTextfield.text!
            saveName(items: items2, key: "udName2")
            print("名前変更\(items2[flag2].location)")
        }
        savePoints(points: points, key: "udPoint")
        }
    
    func savePoints(points: [[Geof]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points) else {
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
    
    func saveFlag(items: Int, key: String) {
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
    
}

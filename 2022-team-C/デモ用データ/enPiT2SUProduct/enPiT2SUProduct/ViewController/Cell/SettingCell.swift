//
//  SettingCell.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/28.
//

import UIKit
import CoreLocation

class SettingCell: UITableViewCell, CLLocationManagerDelegate {

    @IBOutlet weak var settingswitch: UISwitch!
    @IBOutlet weak var settinglabel: UILabel!
    
    var userDefaults = UserDefaults.standard
    
    var points = [[Geof]]()
    var flag2 : Int = 0
    var manager1 : CLLocationManager!
    var monitoringRegion = [[CodableCircularRegion]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        
        manager1 = CLLocationManager()
        manager1.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        
        if loadFlag(key: "udFlag") != nil {
            flag2 = loadFlag(key: "udFlag")!
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if sender.isOn == true{
            print("On")
            if sender.tag == 1{
                points[0][flag2].dateswitch = true
                savePoints(points: points, key: "udPoint")
                print("date,on\(points)")
            } else if (sender.tag == 0){
                points[0][flag2].notification = true
                if (points[0][flag2].locationaddress != "場所の住所を登録してください。"){
                    let monitoringCoodinate = CLLocationCoordinate2DMake(points[0][flag2].latitude,
                                                                         points[0][flag2].longitude)
                    monitoringRegion[flag2] = [CodableCircularRegion.init(CLCircularRegion(center: monitoringCoodinate,
                                                                                            radius: CLLocationDistance(100), identifier: points[0][flag2].locationaddress))]
                    manager1.startMonitoring(for: monitoringRegion[flag2][monitoringRegion[flag2].endIndex - 1].region!)
                    
                    saveRegions(points: monitoringRegion, key: "udRegion")
                    print("追加region,on\(monitoringRegion)")
                }
                savePoints(points: points, key: "udPoint")
                print("notifi,on\(points)")
                print("変化なしregion,on\(monitoringRegion)")
            }
        } else {
            print("Off")
            if sender.tag == 1{
                points[0][flag2].dateswitch = false
                savePoints(points: points, key: "udPoint")
                print("off\(points)")
            } else if (sender.tag == 0){
                points[0][flag2].notification = false
                if (points[0][flag2].locationaddress != "場所の住所を登録してください。"){
                    manager1.stopMonitoring(for: monitoringRegion[flag2][0].region!)
                    monitoringRegion[flag2].removeAll()
                    saveRegions(points: monitoringRegion, key: "udRegion")
                    print("削除region,off\(monitoringRegion)")
                }
                savePoints(points: points, key: "udPoint")
                print("notifi,off\(points)")
                print("変化なしregion,off\(monitoringRegion)")
            }
        }
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
    
    func saveRegions(points: [[CodableCircularRegion]], key: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(points)
        else {
            return
        }
        userDefaults.set(data, forKey: key)
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

//
//  AppDelegate.swift
//  enPiT2SUProduct
//
//  Created by 後藤祐一 on 2022/10/02.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    
    var points = [[Geof]]()
    var monitoringRegion = [[CodableCircularRegion]]()
    var exitregion = CLCircularRegion.self
    var identifier = ""
     
    /*
    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    
    var points = [[Geof]]()
    var monitoringRegion : [CodableCircularRegion] = []
    var identifier = ""
     */

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
        { (granted, _) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            if #available(iOS 14.0, *) {
                completionHandler([[.banner, .list, .sound]])
            } else {
                completionHandler([[.alert, .sound]])
            }
        }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
           //　Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           // Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        
        if loadRegions(key: "udRegion") != nil{
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if loadPoints(key: "udPoint") != nil{
            points = loadPoints(key: "udPoint")!
        }
        
        /*for i in 0 ..< (monitoringRegion.count){
            for a in 0 ..< (monitoringRegion[i].count){
                if (monitoringRegion[a][i].region?.identifier == identifier){
                    for j in 0 ..< (points.count){
                        for k in 0 ..< (points[j].count){
                            if(points[j][k].locationname == identifier){
                                initialViewController.getTopMostViewController()
                                initialViewController.ChangeVC(f1: a)
                            }
                        }
                    }
                }
            }
        }*/
        
        for i in 0 ..< (monitoringRegion.count){
            if (monitoringRegion[i].isEmpty != true){
                if (monitoringRegion[i][0].region?.identifier == identifier){
                    for j in 0 ..< (points.count){
                        for k in 0 ..< (points[j].count){
                            if(points[j][k].locationaddress == identifier){
                                initialViewController.getTopMostViewController()
                                initialViewController.ChangeVC(f1: i)
                            }
                        }
                    }
                }
            }
        }
        
        completionHandler()
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
    
    func loadRegions(key: String) -> [[CodableCircularRegion]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let regions = try? jsonDecoder.decode([[CodableCircularRegion]].self, from: data) else {
            return nil
        }
        return regions
    }
    
    /*func loadRegions(key: String) -> [CodableCircularRegion]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let regions = try? jsonDecoder.decode([CodableCircularRegion].self, from: data) else {
            return nil
        }
        return regions
    }*/


}

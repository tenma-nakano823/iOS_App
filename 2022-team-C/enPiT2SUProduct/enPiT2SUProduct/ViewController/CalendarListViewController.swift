//
//  CalendarListViewController.swift
//  enPiT2SUProduct
//
//  Created by 仲野天真 on 2022/12/30.
//

import UIKit

struct LocalList: Codable {
    var title: String
    var subtitle: String
}

class CalendarListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locallistlabel: UILabel!
    var points = [[Geof]]()
    var provPoints = [LocalList]()
    var selectedAddress: String = ""
    
    var userDefaults = UserDefaults.standard

    @IBOutlet weak var calendarlistTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登録済み住所"
        
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadTest(key: "udTestItem") != nil {
            selectedAddress = loadTest(key: "udTestItem")!
        }
        provPoints = []
        
        calendarlistTabelView.delegate = self
        calendarlistTabelView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            presentingViewController?.beginAppearanceTransition(false, animated: animated)
        }
        if loadPoints(key: "udPoint") != nil {
            points = loadPoints(key: "udPoint")!
        }
        if loadTest(key: "udTestItem") != nil {
            selectedAddress = loadTest(key: "udTestItem")!
        }
        
        provPoints = []
        
        for _ in 0..<points.count {
            if (points[0].isEmpty != true){
                for i in 0..<points[0].count {
                    if (points[0][i].locationaddress != "場所の住所を登録してください。" || points[0][i].locationaddress != ""){
                        provPoints.append(LocalList(title: points[0][i].locationname, subtitle: points[0][i].locationaddress))
                    }
                }
            }
        }
        
        if(provPoints.isEmpty == true) {
            locallistlabel?.text = "予定なし"
            locallistlabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        } else {
            locallistlabel?.text = ""
        }
        calendarlistTabelView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            presentingViewController?.beginAppearanceTransition(true, animated: animated)
            presentingViewController?.endAppearanceTransition()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarlistCell", for: indexPath)
        cell.textLabel?.text = provPoints[indexPath.row].title
        cell.detailTextLabel?.text = provPoints[indexPath.row].subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAddress = provPoints[indexPath.row].subtitle
        print("選択\(selectedAddress)")
        saveTest(items: selectedAddress, key: "udTestItem")
        performSegue(withIdentifier: "exit5", sender: nil)
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveTest(items: String, key: String) {
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
    
    func loadTest(key: String) -> String? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
              let flag = try? jsonDecoder.decode(String.self,
                                                   from: data)
        else {
            return nil
        }
        return flag
    }
}

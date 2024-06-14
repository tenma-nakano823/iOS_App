//
//  SearchViewController.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2022/12/19.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    var text: String = ""
    var searchResults = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchCompleter.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCompleter.queryFragment = text
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.removeAll()
        
        if !searchCompleter.results.isEmpty{
            //print("searchCompleter.results.count = \(searchCompleter.results.count)")
            for i in 0...searchCompleter.results.count - 1{
                var temp = [String]()
                temp.append(searchCompleter.results[i].title)
                temp.append(searchCompleter.results[i].subtitle)
                searchResults.append(temp)
            }
        }
        
        //存在しない店だった場合、subtileは「Search Nearby」か「""」になる。
        
        var listcount = searchResults.count
        
        if !searchResults.isEmpty{
            for i in 0...listcount-1{
                var j = listcount - 1 - i
                let address = searchResults[j][1]
                var addresslist:[String] = address.components(separatedBy: ", ")
                if address == "Search Nearby" || address == "" || addresslist.count <= 2 || address == "近くを検索"{
                    searchResults.remove(at: j)
                }
            }
        }
        searchResults.append(["住所検索","\(text)"])
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let completion = searchResults[indexPath.row][0]
        cell.textLabel?.text = completion
        cell.detailTextLabel?.text = searchResults[indexPath.row][1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = searchResults[indexPath.row]
        var item = searchResults[indexPath.row][1]
        
        let geocoder = CLGeocoder()
        var searchStr: String
        searchStr = item
        
        geocoder.geocodeAddressString(searchStr){ (placemarks, error) in
            if(error == nil) {
                for placemark in placemarks! {
                    let location: CLLocation = placemark.location!
                    let newLatitude = location.coordinate.latitude
                    let newLongitude = location.coordinate.longitude
                    
                    print("緯度： \(newLatitude)")
                    print("経度： \(newLongitude)")
                    
                    // 緯度経度渡し
                    UserDefaults.standard.set(newLatitude, forKey: "newLatitude")
                    UserDefaults.standard.set(newLongitude, forKey: "newLongitude")
                    self.performSegue(withIdentifier: "exit2", sender: nil)
                    self.performSegue(withIdentifier: "exit3", sender: nil)
                }
            } else {
                searchStr = ""
                geocoder.geocodeAddressString(searchStr){ (placemarks, error) in
                    if(error == nil) {
                        for placemark in placemarks! {
                            let location: CLLocation = placemark.location!
                            let newLatitude = location.coordinate.latitude
                            let newLongitude = location.coordinate.longitude
                            
                            print("緯度： \(newLatitude)")
                            print("経度： \(newLongitude)")
                            
                            // 緯度経度渡し
                            UserDefaults.standard.set(newLatitude, forKey: "newLatitude")
                            UserDefaults.standard.set(newLongitude, forKey: "newLongitude")
                            self.performSegue(withIdentifier: "exit2", sender: nil)
                            self.performSegue(withIdentifier: "exit3", sender: nil)
                        }
                    } else {
                        print("検索失敗")
                    }
                }
            }
        }
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

extension SearchViewController : MKLocalSearchCompleterDelegate {
        // 正常に検索結果が更新されたとき
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        tableView.reloadData()
        //        print("completerDidUpdateResults\n")
    }
        
        // 検索が失敗したとき
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // エラー処理
        //        print("error\n")
    }
}

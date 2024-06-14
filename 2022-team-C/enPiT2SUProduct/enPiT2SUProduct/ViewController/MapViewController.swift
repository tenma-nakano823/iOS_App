//
//  MapViewController.swift
//  Test_park
//
//  Created by Sion Park on 2022/11/07
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var flag2: Int = 0
    var temp : [[Geof]] = [[]]
    var items2: [Info2] = []
    var switcher = true
    var text : String = ""
    
    var manager : CLLocationManager!
    let userDefaults = UserDefaults.standard
    var my_latitude: CLLocationDegrees!
    var my_longitude: CLLocationDegrees!
    
    var monitoringRegion = [[CodableCircularRegion]]()
    var radius = CLLocationDistance(100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "長押しでピン"
        // バックグラウンドでの位置情報取得
        manager = CLLocationManager()
        manager.delegate = self

        mapView.delegate = self
        searchTextField.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if loadPoints(key: "udPoint") != nil {
            temp = loadPoints(key: "udPoint")!
        }
        
         if loadRegions(key: "udRegion") != nil {
             monitoringRegion = loadRegions(key: "udRegion")!
         }
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        //起動時、現在地を中心にマップを表示
        manager.startUpdatingLocation()
        my_latitude = manager.location?.coordinate.latitude
        my_longitude = manager.location?.coordinate.longitude

        let current = CLLocation(latitude: my_latitude, longitude: my_longitude)
        let region = MKCoordinateRegion(center: current.coordinate,
                                        latitudinalMeters: 500,longitudinalMeters: 500)
        mapView.setRegion(region, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if loadPoints(key: "udPoint") != nil {
            temp = loadPoints(key: "udPoint")!
            switcher = temp[0][flag2].notification
            print("スイッチ\(switcher)")
        }
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        print(manager.monitoredRegions)
        
        //常に位置情報を取得することを許可してもらう
        if (manager.authorizationStatus == .authorizedWhenInUse) {
            manager.requestAlwaysAuthorization()
        }

    }
    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        let location: CGPoint = sender.location(in: mapView)
        
        if (sender.state == UIGestureRecognizer.State.ended){
            
            let mapPoint: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
            
            if (switcher == true) {
                //円を表示
                let circle = MKCircle(center: mapPoint, radius: radius)
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                mapView.addOverlay(circle)
            }
            
            //ピン表示
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            if mapView.annotations.count > 0 {
                mapView.removeAnnotations(mapView.annotations)
            }
            mapView.addAnnotation(annotation)
            
            navigationItem.title = "ピンをタップで登録"
            //ピンを中心に表示
            let current = CLLocation(latitude: annotation.coordinate.latitude,
                                     longitude: annotation.coordinate.longitude)
            let region = MKCoordinateRegion(center: current.coordinate,
                                            latitudinalMeters: radius + 500,
                                            longitudinalMeters: radius + 500);
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        var mapPoint: CLLocationCoordinate2D = mapView.annotations[0].coordinate
        
        for i in 0 ..< (mapView.annotations.count) {
            if mapView.annotations[i] is MKPointAnnotation {
                mapPoint = mapView.annotations[i].coordinate
            }
        }
        //アラート
        let alert = UIAlertController(title: "ピンの場所を登録しますか？", message: nil,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "キャンセル",
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "登録",
                                      style: UIAlertAction.Style.default)
                        { [self] _ in
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
            geocoder.reverseGeocodeLocation(location) { [self] (placemarks, error) in
                guard let placemark = placemarks?.first else { return }
                self.text = "\(placemark.administrativeArea!)\(placemark.locality!)\(placemark.thoroughfare!)\(placemark.subThoroughfare!)"
                
                //通知設定による
                if (switcher == true) {
                    //長押しした点を中心に、設定した半径のGeoFenceを設定し、配列に格納
                    let monitoringCoodinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
                    print(text)
                    monitoringRegion[flag2] = [CodableCircularRegion.init(CLCircularRegion(center: monitoringCoodinate,
                                                                                           radius: radius, identifier: text))]
                    //monitoringRegion[flag2] += [CodableCircularRegion.init(CLCircularRegion(center: monitoringCoodinate,
                    //                                                                radius: radius, identifier: text))]
                    /*manager.startMonitoring(for: monitoringRegion[flag2][monitoringRegion[flag2].endIndex - 1].region!)*/
                    manager.startMonitoring(for: monitoringRegion[flag2][0].region!)
                    print("アラートによる追加\(manager.monitoredRegions)")
                    saveRegions(points: monitoringRegion, key: "udRegion")
                }
                
                //temp[0][flag2].locationname = text
                temp[0][flag2].locationaddress = text
                temp[0][flag2].latitude = mapPoint.latitude
                temp[0][flag2].longitude = mapPoint.longitude
                //temp[0][flag2].notification: true
                //temp[0][flag2].dateswitch: true
                //print("mapで\(temp)")
                savePoints(points: temp, key: "udPoint")
            }
        }
        )
        self.present(alert, animated: true , completion: nil)
    }

    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                        latitudinalMeters: 500, longitudinalMeters: 500);
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func sizeButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        print(mapView.annotations)
        
        var center = mapView.annotations[0].coordinate
        
        for i in 0 ..< (mapView.annotations.count) {
            if mapView.annotations[i] is MKPointAnnotation {
                center = mapView.annotations[i].coordinate
            }
        }
        
        let radius100 = UIAlertAction(title: "100m", style: .default) { [self] action in
            radius = CLLocationDistance(100)
            
            if (mapView.annotations.count == 2){
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                let circle = MKCircle(center: center, radius: radius)
                mapView.addOverlay(circle)
                
                let region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius + 500,
                                                longitudinalMeters: radius + 500);
                mapView.setRegion(region, animated: true)
            }
        }
        let radius200 = UIAlertAction(title: "200m", style: .default) { [self] action in
            radius = CLLocationDistance(200)
            
            if (mapView.annotations.count == 2){
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                
                let circle = MKCircle(center: center, radius: radius)
                mapView.addOverlay(circle)
                
                let region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius + 500,
                                                longitudinalMeters: radius + 500);
                mapView.setRegion(region, animated: true)
            }
        }
        let radius300 = UIAlertAction(title: "300m", style: .default) { [self] action in
            radius = CLLocationDistance(300)
            
            if (mapView.annotations.count == 2){
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                let circle = MKCircle(center: center, radius: radius)
                mapView.addOverlay(circle)
                
                let region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius + 500,
                                                longitudinalMeters: radius + 500);
                mapView.setRegion(region, animated: true)
            }
        }
        let radius400 = UIAlertAction(title: "400m", style: .default) { [self] action in
            radius = CLLocationDistance(400)
            
            if (mapView.annotations.count == 2){
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                let circle = MKCircle(center: center, radius: radius)
                mapView.addOverlay(circle)
                
                let region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius + 500,
                                                longitudinalMeters: radius + 500);
                mapView.setRegion(region, animated: true)
            }
        }
        let radius500 = UIAlertAction(title: "500m", style: .default) { [self] action in
            radius = CLLocationDistance(500)
            
            if (mapView.annotations.count == 2){
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                let circle = MKCircle(center: center, radius: radius)
                mapView.addOverlay(circle)
                
                let region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius + 500,
                                                longitudinalMeters: radius + 500);
                mapView.setRegion(region, animated: true)
            }
        }
        // キャンセルボタン
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(radius100)
        alert.addAction(radius200)
        alert.addAction(radius300)
        alert.addAction(radius400)
        alert.addAction(radius500)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func endLocation(_ sender: UITextField) {
        if (searchTextField.text != ""){
            performSegue(withIdentifier: "toSearchView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSearchView"){
            let controller = segue.destination as! SearchViewController
            controller.text = searchTextField.text!
        }
    }
    
    @IBAction func searchUnwind(_ unwindSegue: UIStoryboardSegue) {
        let newlatitude = userDefaults.object(forKey: "newLatitude")
        let newlongitude = userDefaults.object(forKey: "newLongitude")
        
        let mapPoint = CLLocationCoordinate2D(latitude: newlatitude as! CLLocationDegrees,
                                              longitude: newlongitude as! CLLocationDegrees)
        navigationItem.title = "ピンをタップで登録"
        
        if (switcher == true) {
            //円を表示
            let circle = MKCircle(center: mapPoint, radius: radius)
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(circle)
        }
        
        //ピン表示
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapView.addAnnotation(annotation)
        
        //ピンを中心に表示
        let current = CLLocation(latitude: annotation.coordinate.latitude,
                                 longitude: annotation.coordinate.longitude)
        let region = MKCoordinateRegion(center: current.coordinate,
                                        latitudinalMeters: radius + 500,
                                        longitudinalMeters: radius + 500);
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        let status = manager.authorizationStatus
        switch status {
        case .notDetermined:
            print("ユーザー認証未選択")
            break
        case .denied:
            print("ユーザーが位置情報取得を拒否しています。")
            //位置情報取得を促す処理を追記
            break
        case .restricted:
            print("位置情報サービスを利用できません")
            break
        case .authorizedWhenInUse:
            print("アプリケーション起動時のみ、位置情報の取得を許可されています。")
            manager.requestLocation()
            break
        case .authorizedAlways:
            print("このアプリケーションは常時、位置情報の取得を許可されています。")
            break
        default:
            print("default")
            break
        }
    }
    
    func locationManager(_ manager1: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locations : \(locations)")
    }
    func locationManager(_ manager1: CLLocationManager, didFailWithError error: Error) {
        print("error : \(error)")
    }

    //userdefaults用の関数
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

    
    func loadPoints(key: String) -> [[Geof]]? {
        let jsonDecoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key),
                let points = try? jsonDecoder.decode([[Geof]].self,
                                                     from: data) else {
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

}

extension MapViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor.blue
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}



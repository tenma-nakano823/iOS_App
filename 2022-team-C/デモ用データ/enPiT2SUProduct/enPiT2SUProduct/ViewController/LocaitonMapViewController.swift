//
//  LocationMapViewController.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2022/11/27.
//

import UIKit
import MapKit
import CoreLocation

class LocationMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var manager: CLLocationManager!
    var index: Int = 0 // Locationのindexの値を格納
    var flag2: Int = 0
    var switcher: Bool = false
    var text : String = ""
    
    var my_latitude: CLLocationDegrees!
    var my_longitude: CLLocationDegrees!
    var monitoringRegion = [[CodableCircularRegion]]()
    var radius = CLLocationDistance(100)
    
    var temp : [[Geof]] = [[]]
    var items2 : [Info2] = []
    
    let userDefaults = UserDefaults.standard
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
        let location:CGPoint = sender.location(in: mapView)
        
        if (sender.state == UIGestureRecognizer.State.ended){
            
            let mapPoint: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
            
            if (switcher == true) {
                //円を表示
                radius = CLLocationDistance(100)
                let circle = MKCircle(center: mapPoint, radius: radius)
                if mapView.overlays.count > 0 {
                    mapView.removeOverlays(mapView.overlays)
                }
                mapView.addOverlay(circle)
            }
            
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            if mapView.annotations.count > 0 {
                mapView.removeAnnotations(mapView.annotations)
            }
            mapView.addAnnotation(annotation)
            
            let current = CLLocation(latitude: annotation.coordinate.latitude,
                                     longitude: annotation.coordinate.longitude)
            let region = MKCoordinateRegion(center: current.coordinate,
                                            latitudinalMeters: 500, longitudinalMeters: 500);
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
                
                
                if (switcher == true) {
                    let monitoringCoodinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
                    monitoringRegion[flag2]/*[0].region*/ = [CodableCircularRegion.init(CLCircularRegion(center: monitoringCoodinate,
                                                                                                         radius: radius, identifier: text))]
                    print("locationmapの方のアラート\(monitoringRegion)")
                    
                    
                    saveRegions(points: monitoringRegion, key: "udRegion")
                }
                
                temp[0][flag2].locationaddress = text
                temp[0][flag2].longitude = mapPoint.longitude
                temp[0][flag2].latitude = mapPoint.latitude
                savePoints(points: temp, key: "udPoint")
            }
        }
        )
        self.present(alert, animated: true , completion: nil)
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


    
    @IBAction func currentButtonTapped(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                        latitudinalMeters: 500, longitudinalMeters: 500);
        mapView.setRegion(region, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        
        mapView.delegate = self
        searchField.delegate = self
        
        if loadPoints(key: "udPoint") != nil {
            temp = loadPoints(key: "udPoint")!
            switcher = temp[0][flag2].notification
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
        
        my_latitude = temp[0][flag2].latitude
        my_longitude = temp[0][flag2].longitude
        let current = CLLocation(latitude: my_latitude, longitude: my_longitude)
        var region = MKCoordinateRegion(center: current.coordinate,
                                        latitudinalMeters: 500,longitudinalMeters: 500)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(my_latitude, my_longitude)
        
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapView.addAnnotation(annotation)
        
        if (switcher == true){
            // 範囲円を表示
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            if (monitoringRegion[flag2].isEmpty != true) {
                radius = monitoringRegion[flag2][0].region!.radius
                let circle = MKCircle(center: monitoringRegion[flag2][0].region!.center, radius: radius)
                mapView.addOverlay(circle)
                region = MKCoordinateRegion(center: monitoringRegion[flag2][0].region!.center,
                                            latitudinalMeters: radius + 500, longitudinalMeters: radius + 500);
            }
        }
        mapView.setRegion(region, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if loadPoints(key: "udPoint") != nil {
            temp = loadPoints(key: "udPoint")!
        }
        
        if loadRegions(key: "udRegion") != nil {
            monitoringRegion = loadRegions(key: "udRegion")!
        }
        if loadName(key: "udName2") != nil {
            items2 = loadName(key: "udName2")!
        }
    }
    
    @IBAction func endEditting(_ sender: UITextField) {
        if (searchField.text != ""){
            performSegue(withIdentifier: "toSearchView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSearchView"){
            let controller = segue.destination as! SearchViewController
            controller.text = searchField.text!
        }
    }
    
    @IBAction func searchUnwind2(_ unwindSegue: UIStoryboardSegue) {
        let newlatitude = userDefaults.object(forKey: "newLatitude")
        let newlongitude = userDefaults.object(forKey: "newLongitude")
        
        let mapPoint = CLLocationCoordinate2D(latitude: newlatitude as! CLLocationDegrees,
                                              longitude: newlongitude as! CLLocationDegrees)
        
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

extension LocationMapViewController {
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

extension LocationMapViewController : MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("SearchCompleter Error.")
    }
}

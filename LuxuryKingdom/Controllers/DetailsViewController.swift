//
//  ServiceDetailsViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 15/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class DetailsViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var detailTextLAbel: UILabel!
    @IBOutlet weak var serviceTitleText: UILabel!
    @IBOutlet var enableLocationView: UIView!
    
    var isMapHidden = false
    var locationManager = CLLocationManager()
    var mapTypesSegment = UISegmentedControl()
    let destinationMarker = GMSMarker()
    let userMarker = GMSMarker()
    var showEnableLocationView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        let mapButton = UIBarButtonItem(image: UIImage(named: "MapsIcon"), style: .plain, target: self, action: #selector(mapButtonTapped))
        self.navigationItem.rightBarButtonItem  = mapButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "DETAILS"
        
        //Service Text
        serviceTitleText.text = "Rolls Royce BZ".uppercased()
        detailTextLAbel.text = "Book a memorable ride in one of the world's most exotic luxury motors - the luxury awaits you.".uppercased()
        
        //Rquest Button
        requestButton.layer.cornerRadius = requestButton.frame.size.height/2
        
        
        //Drop service location pin on Map
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        let camera = GMSCameraPosition.camera(withLatitude: 37.773972, longitude:-122.431297, zoom: 6.0)
        mapView.camera = camera
        
        destinationMarker.position = camera.target
        destinationMarker.snippet = serviceTitleText.text
        destinationMarker.appearAnimation = .pop
        destinationMarker.map = mapView
        mapView.selectedMarker = destinationMarker//shows marker popped up
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self

        //Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied{
                showEnableLocationView = true
            }else{
                showEnableLocationView = false
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    //MARK: - Delegate method for CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let center: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        userMarker.position = center
        userMarker.snippet = "You"
        userMarker.appearAnimation = .pop
        userMarker.map = mapView
        
        /*draw straight line without driving route
        let path = GMSMutablePath()
        path.addLatitude(destinationMarker.position.latitude, longitude:destinationMarker.position.longitude)
        path.addLatitude(userMarker.position.latitude, longitude:userMarker.position.longitude)

        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 3.0
        polyline.map = mapView*/
        
        drawPolylineRoute(from: userMarker.position, to: destinationMarker.position)
    }
    
    //MARK: - Delegate method for GMSMapView
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let viewBG:UIView = Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)? [0] as! UIView
        viewBG.backgroundColor = .white
        viewBG.layer.cornerRadius = 5
        
        let label:UILabel = viewBG.viewWithTag(1) as! UILabel
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 8
        label.text = "\(marker.snippet ?? "Directions")"
        label.sizeToFit()

        let navigateIconWidth:CGFloat = 18
        let standardSpacings:CGFloat = 24
        let frameWidth = (label.frame.size.width > view.frame.width/2) ? view.frame.width/2 : label.frame.width
        viewBG.frame = CGRect(x:0, y:0, width: frameWidth + navigateIconWidth + standardSpacings, height: viewBG.frame.height)

        return viewBG
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        navigate(marker: marker)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    //MARK: - Other Cool Stuff
    @objc func navigate(marker: GMSMarker) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {//open in GoogleMaps app
            UIApplication.shared.open(URL(string:
                "comgooglemaps://?saddr=\(userMarker.position.latitude),\(userMarker.position.longitude)&daddr=\(destinationMarker.position.latitude),\(destinationMarker.position.longitude)&directionsmode=driving")!, options: [:], completionHandler: nil)
        }else{//open in browser
            UIApplication.shared.open(URL(string:"https://www.google.com/maps/dir/?api=1&origin=\(userMarker.position.latitude),\(userMarker.position.longitude)&destination=\(destinationMarker.position.latitude),\(destinationMarker.position.longitude)&travelmode=driving")!, options: [:], completionHandler: nil)
        }
    }
    
    func drawPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=true&mode=driving")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        guard let routes = json["routes"] as? NSArray else { return }
                        
                        if (routes.count > 0) {
                            let overview_polyline = routes[0] as? NSDictionary
                            let dictPolyline = overview_polyline?["overview_polyline"] as? NSDictionary
                            
                            let points = dictPolyline?.object(forKey: "points") as? String
                            
                            DispatchQueue.main.async {
                                self.showPath(polyStr: points!)
                                let bounds = GMSCoordinateBounds(coordinate: source, coordinate: destination)
                                let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsetsMake(170, 30, 30, 30))
                                self.mapView.moveCamera(update)
                            }
                        }
                    }
                }
                catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.blue
        polyline.map = mapView
    }
    
    
    @IBAction func enableLocation(_ sender: UIButton) {
        //permission denied show them the way to re-enable location service.
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: { (success) in
            self.enableLocationView.isHidden = true
            self.showEnableLocationView = false
            
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        })
        
    }
    
    @IBAction func removeAskLocationView(_ sender: UIButton) {
        enableLocationView.isHidden = true
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func mapButtonTapped() {

        enableLocationView.isHidden = !showEnableLocationView

        mapView.isHidden = isMapHidden
        if mapView.isHidden{
            let mapButton = UIBarButtonItem(image: UIImage(named: "MapsIcon"), style: .plain, target: self, action: #selector(mapButtonTapped))
            self.navigationItem.rightBarButtonItem = mapButton
            mapTypesSegment.removeFromSuperview()
            enableLocationView.isHidden = true
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(mapButtonTapped))
            //Draw maptypes
            let heightOfSegment:CGFloat = 30

            mapView.mapType = .normal

            let mapTypes = ["Map", "Satellite"]
            mapTypesSegment = UISegmentedControl(items: mapTypes)
            mapTypesSegment.selectedSegmentIndex = 0
            mapTypesSegment.tintColor = UIColor(named:"BlackBackground")
            
            
            let navBar = self.navigationController?.navigationBar.frame
            
            mapTypesSegment.frame = CGRect(x: (navBar?.width)!/2 - ((navBar?.width)!/2)/2, y: (navBar?.maxY)!+8, width: (navBar?.width)!/2, height: heightOfSegment)
            
            mapTypesSegment.addTarget(self, action: #selector(changeMapType), for: .valueChanged)
            
            
            self.navigationController?.navigationBar.superview?.insertSubview(mapTypesSegment, belowSubview: (self.navigationController?.navigationBar)!)
        }
        isMapHidden = !isMapHidden
        scrollView.isHidden = isMapHidden
        
    }
    
    @objc func changeMapType(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            mapView.mapType = .normal
            mapTypesSegment.tintColor = UIColor(named:"BlackBackground")
        }else{
            mapView.mapType = .satellite
            mapTypesSegment.tintColor = UIColor(named:"ContrastWhite")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapTypesSegment.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



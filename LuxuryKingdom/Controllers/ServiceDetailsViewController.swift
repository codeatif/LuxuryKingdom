//
//  ServiceDetailsViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 15/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit
import MapKit

class ServiceDetailsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var detailTextLAbel: UILabel!
    @IBOutlet weak var serviceTitleText: UILabel!
    
    var isMapHidden = false
    var locationManager = CLLocationManager()
    var currentRouteOverlay : MKOverlay?
    var destinationCoordinate = CLLocationCoordinate2D()
    var userCurrentLocMapItem = MKMapItem()
    var destinationLocMapItem = MKMapItem()
    var mapTypesSegment = UISegmentedControl()
    
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
        mapView.showsUserLocation = true

        let destinationAnnotation = MKPointAnnotation()
        //        destinationCoordinate = CLLocationCoordinate2D(latitude: 28.539501, longitude:77.344490)//nearby logix techno park
        //        destinationCoordinate = CLLocationCoordinate2D(latitude: 25.141050, longitude:55.185978)//Burj Dubai
        destinationCoordinate = CLLocationCoordinate2D(latitude: 40.800178, longitude:-73.132376)//empire state building, NY
        destinationAnnotation.coordinate = destinationCoordinate
        destinationAnnotation.title = "Burj Khalifa"
        mapView.addAnnotation(destinationAnnotation)
        
        //now show this annotation automatically , index shows which annotation to show
        mapView.selectAnnotation(mapView.annotations[0], animated: true)
        
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: destinationAnnotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        //Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            //permission denied show them the way to re-enable location service.
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }
        
        //type of map standard(0), satellite(1) or hybrid(2)
        mapView.mapType = MKMapType.init(rawValue: UInt(0)) ?? .standard
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        region.center = mapView.userLocation.coordinate
        if region.center.latitude > 0 && region.center.longitude > 0{
            mapView.setRegion(region, animated: true)
            mapView.selectAnnotation(mapView.annotations[0], animated: true)
        }
        
        //right so, we have the user location, let us now create our source and destination mapitems to be launched in map later
        let userCurrentLocationPlacemark = MKPlacemark(coordinate: self.mapView.userLocation.coordinate, addressDictionary: nil)
        userCurrentLocMapItem = MKMapItem(placemark: userCurrentLocationPlacemark)
        
        let selectedPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        destinationLocMapItem = MKMapItem(placemark: selectedPlacemark)
        
        self.createRouteTo(fromMapItem:userCurrentLocMapItem, selectedMapItem: destinationLocMapItem)
    }
    
    
    //draw a custom view with button on top of our annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            
            //next line sets a button for the right side of the callout...
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x:0, y:0, width: 25, height: 25)
            btn.setImage(#imageLiteral(resourceName: "NavigateIcon") , for: .normal)
            pinView!.rightCalloutAccessoryView = btn
        }
        else {
            pinView!.annotation = annotation
        }

        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let mapItems = [userCurrentLocMapItem, destinationLocMapItem]
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
    }
    
    //STEP:2 - design the route as colored line over the map (visible)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4
        return renderer
    }
    
    //STEP:1 - create the route (invisible) between locations
    func createRouteTo(fromMapItem: MKMapItem,selectedMapItem: MKMapItem) {
        
        if(CLLocationCoordinate2DIsValid(mapView.userLocation.coordinate) && CLLocationCoordinate2DIsValid(selectedMapItem.placemark.coordinate))
        {
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: fromMapItem.placemark.coordinate, addressDictionary: nil))
            directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedMapItem.placemark.coordinate, addressDictionary: nil))
            directionRequest.transportType = .automobile
            directionRequest.requestsAlternateRoutes = false
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate { [unowned self] (directionResponse, error) in
                
                guard let response = directionResponse else {
                    if let error = error {
                        print("Error: \(error)")
                        let alert = UIAlertController.init(title:"Can't create route between the location points",
                                                           message:error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction.init(title: "OK", style: .destructive, handler:nil))
                        self.present(alert, animated:true , completion:nil)
                    }
                    return
                }
                
                if self.currentRouteOverlay != nil {
                    self.mapView.remove(self.currentRouteOverlay!)
                }
                
                let route = response.routes[0]
                self.currentRouteOverlay = route.polyline
                self.mapView.add(route.polyline, level: .aboveRoads)
                
                let rect =  route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsetsMake(70, 70, 70, 70), animated: true)
            }
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func mapButtonTapped() {
        mapView.isHidden = isMapHidden
        if mapView.isHidden{
            let mapButton = UIBarButtonItem(image: UIImage(named: "MapsIcon"), style: .plain, target: self, action: #selector(mapButtonTapped))
            self.navigationItem.rightBarButtonItem = mapButton
            mapTypesSegment.removeFromSuperview()
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(mapButtonTapped))
            //Draw maptypes
            let heightOfSegment:CGFloat = 30
            
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
            mapView.mapType = MKMapType.init(rawValue: UInt(0)) ?? .standard//map
            mapTypesSegment.tintColor = UIColor(named:"BlackBackground")
        }else{
            mapView.mapType = MKMapType.init(rawValue: UInt(1)) ?? .standard//satellite
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


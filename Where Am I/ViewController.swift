//
//  ViewController.swift
//  Where Am I
//
//  Created by Gudla Srinivas on 10/19/14.
//  Copyright (c) 2014 sgudla. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
     
        latitude.text = "\(userLocation.coordinate.latitude)"
        longitude.text = "\(userLocation.coordinate.longitude)"
        heading.text = "\(userLocation.course)"
        speed.text = "\(userLocation.speed)"
        altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
            if(error != nil) {
                println(error)
            } else {
                let p:CLPlacemark = CLPlacemark(placemark : placemarks?[0] as CLPlacemark)
                
                var firstLine = ""
                
                if(p.subThoroughfare != nil) {
                    firstLine += p.subThoroughfare
                }
                
                if(p.thoroughfare != nil) {
                    firstLine += p.thoroughfare
                }
                
                
                self.address.text = "\(firstLine)\n \(p.subLocality)\n\(p.subAdministrativeArea)\n\(p.country)-\(p.postalCode)"
            }
            
        })
        
        address.text = "\(userLocation.altitude)"
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


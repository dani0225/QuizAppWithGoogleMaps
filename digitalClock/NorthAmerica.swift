//
//  SecoundViewController.swift
//  digitalClock
//
//  Created by Admin on 12/02/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AudioToolbox


class NorthAmerica: UIViewController, CLLocationManagerDelegate {
    
    
    
    
    
    
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    
    @IBOutlet var nextQuestionOutlet: UIButton!
   
    @IBOutlet var livesLabel: UILabel!
    

    
    @IBOutlet var finishOutlet: UIButton!
    
    @IBOutlet var countQuestionsLabel: UILabel!
    
    
    
    var correctAnswer = String()
    var randomQuestionArray:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
    
    
    var livesNumber:Int = 3
    var countQuestions:Int = 1
    
    var manager = CLLocationManager()
    
   
    
    var latitudeSlovenia:Double = 46.15124099999999
    var longitudeSlovenia:Double = 14.995462999999972
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        button1.layer.cornerRadius = 15
        button2.layer.cornerRadius = 15
        button3.layer.cornerRadius = 15
        button4.layer.cornerRadius = 15
        
        nextQuestionOutlet.isHidden = true
        
        nextQuestionOutlet.layer.cornerRadius = 15
        
        countQuestionsLabel.text = "Q: 1/22"
        
        
        randomQuestions()
        
        
        
        livesLabel.text = "Lives: 3"
        finishOutlet.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func mapType(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            mapView.mapType = MKMapType.standard
        }
        if segmentControl.selectedSegmentIndex == 1 {
            
            mapView.mapType = MKMapType.satellite
        }
        if segmentControl.selectedSegmentIndex == 2 {
            
            mapView.mapType = MKMapType.hybrid
        }
        
    }
    
    
    @IBAction func loacteMe(_ sender: Any) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let span =  MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
   
    func hideButtons() {
        
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        questionLabel.isHidden = true
    }
    
    func unhideButtons() {
        
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        questionLabel.isHidden = false
        
    }
    
    func disable() {
        
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        
    }
    
    func enable() {
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        
    }
    
    
    
    func removeTextColor() {
        
        
        button1.backgroundColor = UIColor(red:206/255, green:180/255, blue:187/255, alpha: 0.4)
        button2.backgroundColor = UIColor(red:206/255, green:180/255, blue:187/255, alpha: 0.4)
        button3.backgroundColor = UIColor(red:206/255, green:180/255, blue:187/255, alpha: 0.4)
        button4.backgroundColor = UIColor(red:206/255, green:180/255, blue:187/255, alpha: 0.4)
        
        
        
        button1.setTitleColor(UIColor.white, for: UIControlState.normal)
        button2.setTitleColor(UIColor.white, for: UIControlState.normal)
        button3.setTitleColor(UIColor.white, for: UIControlState.normal)
        button4.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        
        
    }
    
    func loseALife() {
        
        livesNumber -= 1
        
        livesLabel.text = String("Lives: \(livesNumber)")
        
        if livesNumber < 1 {
            
            nextQuestionOutlet.isEnabled = false
            disable()
            finishOutlet.isHidden = false
            finishOutlet.setTitle("Restart Quizz", for: UIControlState.normal)
            nextQuestionOutlet.isHidden = true
        }
        
        
        livesLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.livesLabel.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    
        
    
        
    
      
        
    }
    
   
    
    
  
    
    func didUserWin() {
        
        if countQuestions == 22 && livesNumber > 0 {
            
            
            finishOutlet.isHidden = false
            finishOutlet.setTitle("Congratulations! You completed the quiz", for: UIControlState.normal)
         
            hideButtons()
            nextQuestionOutlet.isHidden = true
        }
        
       
       
        
    }
    
    
    func nextQuestion() {
        
        
        randomQuestions()
        enable()
        removeTextColor()
        nextQuestionOutlet.isHidden = true
        
        
        countQuestions += 1
        
        if countQuestions > 22 {
            countQuestions = 22
        }
        
        countQuestionsLabel.text = String("Q: \(countQuestions)/22")
        
        
        
    }
    
   
    func removeAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        
    }
    
    
    
    func randomQuestions() {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomQuestionArray.count)))
        
        
        if randomQuestionArray.count > 0 {
            
        
        
        
        
        switch(randomQuestionArray[randomIndex]) {
            
        case 1:
            
            
            let latitude:Double = 17.0746557
            let longitude:Double = -61.81752069999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)

            
            
            
            
            
            questionLabel.text = "The capital of Antigua is ..."
            button1.setTitle("Nassau", for: UIControlState.normal)
            button2.setTitle("Saint John's", for: UIControlState.normal)
            button3.setTitle("Bridgetown", for: UIControlState.normal)
            button4.setTitle("Caracas", for: UIControlState.normal)
            
            correctAnswer = "2"
    
            break
        case 2:
            
            
            let latitude:Double = 25.03428
            let longitude:Double = -77.39627999999999
            
            let span = MKCoordinateSpanMake(55, 55)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            questionLabel.text = "The capital of Bahamas is ..."
            button1.setTitle("Kingston", for: UIControlState.normal)
            button2.setTitle("Managua", for: UIControlState.normal)
            button3.setTitle("Belmopan", for: UIControlState.normal)
            button4.setTitle("Nassau", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 3:
            
            let latitude:Double = 13.193887
            let longitude:Double = -59.54319799999996
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Barbados is ...?"
            button1.setTitle("Bridgetown", for: UIControlState.normal)
            button2.setTitle("Port of Spain", for: UIControlState.normal)
            button3.setTitle("Cordoba", for: UIControlState.normal)
            button4.setTitle("Castries", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 4:
            
            
            let latitude:Double = 17.2510114
            let longitude:Double = -88.75902009999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Belize is ...?"
            button1.setTitle("Santo Domingo", for: UIControlState.normal)
            button2.setTitle("Belmopan", for: UIControlState.normal)
            button3.setTitle("Quito", for: UIControlState.normal)
            button4.setTitle("Paramaribo", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 5:
            
            let latitude:Double = 45.4215296
            let longitude:Double = -75.69719309999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Canada is ...?"
            button1.setTitle("San Jose", for: UIControlState.normal)
            button2.setTitle("Ottawa", for: UIControlState.normal)
            button3.setTitle("Roseau", for: UIControlState.normal)
            button4.setTitle("Basseterre", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 6:
            
            
            let latitude:Double = 9.748916999999999
            let longitude:Double = -83.75342799999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Costa Rica is ...?"
            button1.setTitle("Managua", for: UIControlState.normal)
            button2.setTitle("Sucre", for: UIControlState.normal)
            button3.setTitle("Saint John's", for: UIControlState.normal)
            button4.setTitle("San Jose", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 7:
            
            
            let latitude:Double = 21.521757
            let longitude:Double = -77.78116699999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Cuba is ...?"
            button1.setTitle("Caracas", for: UIControlState.normal)
            button2.setTitle("Port au Prince", for: UIControlState.normal)
            button3.setTitle("Havana", for: UIControlState.normal)
            button4.setTitle("Basseterre", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 8:
            
            
            let latitude:Double = 18.48605749999999
            let longitude:Double = -69.9312117
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Dominican Republic is ...?"
            button1.setTitle("Basseterre", for: UIControlState.normal)
            button2.setTitle("Castries", for: UIControlState.normal)
            button3.setTitle("Santo Domingo", for: UIControlState.normal)
            button4.setTitle("Mexico City", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 9:
            
            
            let latitude:Double = 13.794185
            let longitude:Double = -88.89652999999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of El Salvador is ...?"
            button1.setTitle("Managua", for: UIControlState.normal)
            button2.setTitle("Saint John's", for: UIControlState.normal)
            button3.setTitle("San Salvador", for: UIControlState.normal)
            button4.setTitle("Tegucigalpa", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
            
        case 10:
            
            
            let latitude:Double = 12.1165
            let longitude:Double = -61.678999999999974
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Grenada is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Saint George's", for: UIControlState.normal)
            button3.setTitle("Georgetown", for: UIControlState.normal)
            button4.setTitle("Saint John's", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 11:
            
            
            let latitude:Double = 14.6349149
            let longitude:Double = -90.5068824
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Guatemala is ...?"
            button1.setTitle("Tegucigalpa", for: UIControlState.normal)
            button2.setTitle("Guatemala City", for: UIControlState.normal)
            button3.setTitle("Guyana", for: UIControlState.normal)
            button4.setTitle("Kingston", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 12:
            
            
            let latitude:Double = 18.971187
            let longitude:Double = -72.285215
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Haiti is ...?"
            button1.setTitle("Roseau", for: UIControlState.normal)
            button2.setTitle("Basseterre", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Port au Prince", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 13:
            
            
            let latitude:Double = 15.199999
            let longitude:Double = -86.24190499999997
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Honduras is ...?"
            button1.setTitle("Roseau", for: UIControlState.normal)
            button2.setTitle("Basseterre", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Tegucigalpa", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 14:
            
            
            let latitude:Double = 18.0178743
            let longitude:Double = -76.80990409999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Jamaica is ...?"
            button1.setTitle("Roseau", for: UIControlState.normal)
            button2.setTitle("Basseterre", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Kingston", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 15:
            
            
            let latitude:Double = 19.4326077
            let longitude:Double = -99.13320799999997
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Mexico is ...?"
            button1.setTitle("Port of Spain", for: UIControlState.normal)
            button2.setTitle("Mexic", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Mexico City", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 16:
            
            
            let latitude:Double = 12.1149926
            let longitude:Double = -86.23617439999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Nicaragua is ...?"
            button1.setTitle("Washington DC", for: UIControlState.normal)
            button2.setTitle("Ottawa", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Managua", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 17:
            
            
            let latitude:Double = 8.982379199999999
            let longitude:Double = -79.51986959999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Panama is ...?"
            button1.setTitle("Roseau", for: UIControlState.normal)
            button2.setTitle("Panama City", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Port au Prince", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
            
        case 18:
            
            
            let latitude:Double = 17.357822
            let longitude:Double = -62.78299800000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Saint Kitts is ...?"
            button1.setTitle("Basseterre", for: UIControlState.normal)
            button2.setTitle("Guatemala", for: UIControlState.normal)
            button3.setTitle("Roseau", for: UIControlState.normal)
            button4.setTitle("Belmopan", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
            
        case 19:
            
            
            let latitude:Double = 14.0101094
            let longitude:Double = -60.98746870000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Saint Lucia is ...?"
            button1.setTitle("Roseau", for: UIControlState.normal)
            button2.setTitle("Managua", for: UIControlState.normal)
            button3.setTitle("Castries", for: UIControlState.normal)
            button4.setTitle("Bridgetown", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
            
        case 20:
            
            
            let latitude:Double = 13.1600249
            let longitude:Double = -61.22481570000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Saint Vicent is ...?"
            button1.setTitle("San Salvador", for: UIControlState.normal)
            button2.setTitle("San Jose", for: UIControlState.normal)
            button3.setTitle("Kingston", for: UIControlState.normal)
            button4.setTitle("Kingstown", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 21:
            
            
            let latitude:Double = 10.691803
            let longitude:Double = -61.22250300000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Trinidad and Tobago is ...?"
            button1.setTitle("Port of Spain", for: UIControlState.normal)
            button2.setTitle("Havana", for: UIControlState.normal)
            button3.setTitle("Tegucigalpa", for: UIControlState.normal)
            button4.setTitle("Kingstown", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
            
        case 22:
            
            
            let latitude:Double = 38.9071923
            let longitude:Double = -77.03687070000001
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of USA is ...?"
            button1.setTitle("San Jose", for: UIControlState.normal)
            button2.setTitle("Los Angeles", for: UIControlState.normal)
            button3.setTitle("New York", for: UIControlState.normal)
            button4.setTitle("Washington DC", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        default:
            
           
            break
            
        } 
            
            
        randomQuestionArray.remove(at: randomIndex)
        
        }
        
        
    
        
       
    }
    
    
    
    
    @IBAction func directions(_ sender: Any) {
    }
    
    
    @IBAction func button1Action(_ sender: Any) {
        
        disable()
        nextQuestionOutlet.isHidden = false
        nextQuestionOutlet.isEnabled = true
        didUserWin()
        removeAnnotations()
        
        
        
        if(correctAnswer == "1") {
            
            button1.backgroundColor = UIColor.green
            nextQuestion()
            
            
        } else {
            button1.backgroundColor = UIColor.red
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
                
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
               
            }
            if countQuestions == 22 {
                unhideButtons()
            }
            
            loseALife()
            
            
            
            button1.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.20),
                           initialSpringVelocity: CGFloat(6.0),
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button1.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )

            
           
            
        }
    }
    
    @IBAction func button2Action(_ sender: Any) {
        
        disable()
        nextQuestionOutlet.isHidden = false
        nextQuestionOutlet.isEnabled = true
        didUserWin()
        removeAnnotations()
        
        if(correctAnswer == "2") {
            
            
          button2.backgroundColor = UIColor.green
            nextQuestion()
            
        } else {
            button2.backgroundColor = UIColor.red
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
                
            }
            if countQuestions == 22 {
                unhideButtons()
            }
            
        
            
            loseALife()
            
          
            button2.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.20),
                           initialSpringVelocity: CGFloat(6.0),
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button2.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )


            
            
            
            
        }
    }
    
    @IBAction func button3Action(_ sender: Any) {
        
        disable()
        nextQuestionOutlet.isHidden = false
        nextQuestionOutlet.isEnabled = true
        didUserWin()
        removeAnnotations()
        
        if(correctAnswer == "3") {
            button3.backgroundColor = UIColor.green
            nextQuestion()
            
          
        }else {
            button3.backgroundColor = UIColor.red
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

            
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
               
            }
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
                
            }
            if countQuestions == 22 {
                unhideButtons()
            }
            
            loseALife()
          
            
            
            button3.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.20),
                           initialSpringVelocity: CGFloat(6.0),
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button3.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )

            
            
            
           
        }
    }
    
    @IBAction func button4Action(_ sender: Any) {
        
      disable()
        nextQuestionOutlet.isHidden = false
        nextQuestionOutlet.isEnabled = true
        didUserWin()
        removeAnnotations()
        
        if(correctAnswer == "4") {
            button4.backgroundColor = UIColor.green
            nextQuestion()
            
            
           
        }else {
            button4.backgroundColor = UIColor.red
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
               
            }
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
               
            }
            if countQuestions == 22 {
                unhideButtons()
            }
            
            loseALife()
            
            
            
            button4.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.20),
                           initialSpringVelocity: CGFloat(6.0),
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button4.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )

            
            
           
        }
    }
    
    
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        
        randomQuestions()
        enable()
        removeTextColor()
        nextQuestionOutlet.isHidden = true
        
       
        countQuestions += 1
        countQuestionsLabel.text = String("Q: \(countQuestions)/22")
       
        
        
        
       
    }
    
    
    
    
    @IBAction func finishButton(_ sender: Any) {
        
       randomQuestionArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
        
        livesNumber = 3
        countQuestions = 1
        
       livesLabel.text = String("Lives: \(livesNumber)")
        countQuestionsLabel.text = String("Q: \(countQuestions)/22")
        
        enable()
        removeTextColor()
        finishOutlet.isHidden = true
        unhideButtons()
        nextQuestionOutlet.isHidden = true
        
      randomQuestions()
        
        
        
    }
    
    
    
    
}






/* Cum  saaaa how to delete the satus bar with battery indicator and phone service so we will have more space
1. go to info.plist
 2.add in a new line
 3.type status bar is intally hidden = yes
 view controller bases status bar appearence no
 
 */

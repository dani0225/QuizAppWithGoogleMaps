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


class celCorect: UIViewController, CLLocationManagerDelegate {
    
    
    
    
    
    
    
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
    var randomQuestionArray:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
    
    
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
        
        countQuestionsLabel.text = "Q: 1/46"
        
        
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
        
        
        button1.backgroundColor = UIColor(red:106/255, green:207/255, blue:255/255, alpha: 1.0)
       button2.backgroundColor = UIColor(red:106/255, green:207/255, blue:255/255, alpha: 1.0)
        button3.backgroundColor = UIColor(red:106/255, green:207/255, blue:255/255, alpha: 1.0)
        button4.backgroundColor = UIColor(red:106/255, green:207/255, blue:255/255, alpha: 1.0)
        
        
        
        button1.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button2.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button3.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button4.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        
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
        
        if countQuestions == 46 && livesNumber > 0 {
            
            
            finishOutlet.isHidden = false
            finishOutlet.setTitle("Congratulations! You completed the quiz", for: UIControlState.normal)
            finishOutlet.setTitleColor(UIColor.red, for: UIControlState.normal)
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
        
        if countQuestions > 46 {
            countQuestions = 46
        }
        
        countQuestionsLabel.text = String("Q: \(countQuestions)/46")
        
        
        
    }
    
   
    func removeAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        
    }
    
    
    
    func randomQuestions() {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomQuestionArray.count)))
        
        
        if randomQuestionArray.count > 0 {
            
        
        
        
        
        switch(randomQuestionArray[randomIndex]) {
            
        case 1:
            
            
            let latitude:Double = 40.143105
            let longitude:Double = 47.57692700000007
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)

            
            
            
            
            
            questionLabel.text = "The capital of Azerbaijan is ..."
            button1.setTitle("Astana", for: UIControlState.normal)
            button2.setTitle("Baku", for: UIControlState.normal)
            button3.setTitle("Tibilisi", for: UIControlState.normal)
            button4.setTitle("Bucharest", for: UIControlState.normal)
            
            correctAnswer = "2"
    
            break
        case 2:
            
            
            let latitude:Double = 53.709807
            let longitude:Double = 27.953389000000016
            
            let span = MKCoordinateSpanMake(55, 55)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            questionLabel.text = "The capital of Belarus is ..."
            button1.setTitle("Murcia", for: UIControlState.normal)
            button2.setTitle("Moscow", for: UIControlState.normal)
            button3.setTitle("Madeira", for: UIControlState.normal)
            button4.setTitle("Minsk", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 3:
            
            let latitude:Double = 50.503887
            let longitude:Double = 4.4699359999999615
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Belgium is ...?"
            button1.setTitle("Brussels", for: UIControlState.normal)
            button2.setTitle("Bratislava", for: UIControlState.normal)
            button3.setTitle("Benelux", for: UIControlState.normal)
            button4.setTitle("Bruges", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 4:
            
            
            let latitude:Double = 43.915886
            let longitude:Double = 17.67907600000001
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Bosnia is ...?"
            button1.setTitle("Sofia", for: UIControlState.normal)
            button2.setTitle("Sarajevo", for: UIControlState.normal)
            button3.setTitle("Zagreb", for: UIControlState.normal)
            button4.setTitle("Podgorica", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 5:
            
            let latitude:Double = 41.153332
            let longitude:Double = 20.168330999999966
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Albania is ...?"
            button1.setTitle("Tyraspol", for: UIControlState.normal)
            button2.setTitle("Tirana", for: UIControlState.normal)
            button3.setTitle("Tallin", for: UIControlState.normal)
            button4.setTitle("Turin", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 6:
            
            
            let latitude:Double = 42.506285
            let longitude:Double = 1.5218009999999822
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Andorra is ...?"
            button1.setTitle("Astana", for: UIControlState.normal)
            button2.setTitle("Andorra", for: UIControlState.normal)
            button3.setTitle("Valetta", for: UIControlState.normal)
            button4.setTitle("Andorra la Vella", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 7:
            
            
            let latitude:Double = 40.069099
            let longitude:Double = 45.03818899999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Armenia is ...?"
            button1.setTitle("Minsk", for: UIControlState.normal)
            button2.setTitle("Tibilisi", for: UIControlState.normal)
            button3.setTitle("Yerevan", for: UIControlState.normal)
            button4.setTitle("Baku", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 8:
            
            
            let latitude:Double = 47.516231
            let longitude:Double = 14.550072
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Austria is ...?"
            button1.setTitle("Zurich", for: UIControlState.normal)
            button2.setTitle("Bern", for: UIControlState.normal)
            button3.setTitle("Vienna", for: UIControlState.normal)
            button4.setTitle("Vaduz", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 9:
            
            
            let latitude:Double = 42.733883
            let longitude:Double = 25.485829999999964
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Bulgaria is ...?"
            button1.setTitle("Bratislava", for: UIControlState.normal)
            button2.setTitle("Bern", for: UIControlState.normal)
            button3.setTitle("Sofia", for: UIControlState.normal)
            button4.setTitle("Belgrade", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
            
        case 11:
            
            
            let latitude:Double = 45.8150108
            let longitude:Double = 15.981919000000062
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Croatia is ...?"
            button1.setTitle("Zurich", for: UIControlState.normal)
            button2.setTitle("Zagreb", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 12:
            
            
            let latitude:Double = 39.9333635
            let longitude:Double = 32.85974190000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Turkey is ...?"
            button1.setTitle("Istambul", for: UIControlState.normal)
            button2.setTitle("Ankara", for: UIControlState.normal)
            button3.setTitle("Baku", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 13:
            
            
            let latitude:Double = 41.9973462
            let longitude:Double = 21.42799560000003
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Macedonia is ...?"
            button1.setTitle("Tibilisi", for: UIControlState.normal)
            button2.setTitle("Erevan", for: UIControlState.normal)
            button3.setTitle("Reykjavik", for: UIControlState.normal)
            button4.setTitle("Skopje", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 14:
            
            
            let latitude:Double = 51.5073509
            let longitude:Double = -0.12775829999998223
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of England is ...?"
            button1.setTitle("Liverpool", for: UIControlState.normal)
            button2.setTitle("Manchester", for: UIControlState.normal)
            button3.setTitle("London", for: UIControlState.normal)
            button4.setTitle("Dublin", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 15:
            
            
            let latitude:Double = 42.43041960000001
            let longitude:Double = 19.259364199999936
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Montenegro is ...?"
            button1.setTitle("Podgorica", for: UIControlState.normal)
            button2.setTitle("Belgrade", for: UIControlState.normal)
            button3.setTitle("Skopje", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

            
        case 16:
            
            
            let latitude:Double = 41.90278349999999
            let longitude:Double = 12.496365500000024
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Italy is ...?"
            button1.setTitle("Vatican", for: UIControlState.normal)
            button2.setTitle("Rome", for: UIControlState.normal)
            button3.setTitle("Milano", for: UIControlState.normal)
            button4.setTitle("Torino", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 17:
            
            
            let latitude:Double = 55.755826
            let longitude:Double = 37.6173
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Russia is ...?"
            button1.setTitle("Saint Petersburg", for: UIControlState.normal)
            button2.setTitle("Minsk", for: UIControlState.normal)
            button3.setTitle("Kiev", for: UIControlState.normal)
            button4.setTitle("Moscow", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 18:
            
            
            let latitude:Double = 52.52000659999999
            let longitude:Double = 13.404953999999975
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Germany is ...?"
            button1.setTitle("Munich", for: UIControlState.normal)
            button2.setTitle("Zagreb", for: UIControlState.normal)
            button3.setTitle("Berlin", for: UIControlState.normal)
            button4.setTitle("Hamburg", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 19:
            
            
            let latitude:Double = 50.4501
            let longitude:Double = 30.523400000000038
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Ukraine is ...?"
            button1.setTitle("Warsaw", for: UIControlState.normal)
            button2.setTitle("Budapest", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Kiev", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 20:
            
            
            let latitude:Double = 41.7151377
            let longitude:Double = 44.82709599999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Georgia is ...?"
            button1.setTitle("Tibilisi", for: UIControlState.normal)
            button2.setTitle("Tirana", for: UIControlState.normal)
            button3.setTitle("Tiraspol", for: UIControlState.normal)
            button4.setTitle("Tallin", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

            
        case 21:
            
            
            let latitude:Double = 40.4167754
            let longitude:Double = -3.7037901999999576
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Spain is ...?"
            button1.setTitle("Barcelona", for: UIControlState.normal)
            button2.setTitle("Madrid", for: UIControlState.normal)
            button3.setTitle("Paris", for: UIControlState.normal)
            button4.setTitle("Valencia", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 22:
            
            
            let latitude:Double = 47.497912
            let longitude:Double = 19.04023499999994
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Hungary is ...?"
            button1.setTitle("Bucharest", for: UIControlState.normal)
            button2.setTitle("Belgrade", for: UIControlState.normal)
            button3.setTitle("Budapest", for: UIControlState.normal)
            button4.setTitle("Bratislava", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 23:
            
            
            let latitude:Double = 52.2296756
            let longitude:Double = 21.012228700000037
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Poland is ...?"
            button1.setTitle("Bratislava", for: UIControlState.normal)
            button2.setTitle("Vilnius", for: UIControlState.normal)
            button3.setTitle("Praga", for: UIControlState.normal)
            button4.setTitle("Warsaw", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 24:
            
            
            let latitude:Double = 50.0755381
            let longitude:Double = 14.43780049999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Czech Republic is ...?"
            button1.setTitle("Prague", for: UIControlState.normal)
            button2.setTitle("Bucharest", for: UIControlState.normal)
            button3.setTitle("Bratislava", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 25:
            
            
            let latitude:Double = 47.1410303
            let longitude:Double = 9.520927700000016
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Lichtenstein is ...?"
            button1.setTitle("Vaduz", for: UIControlState.normal)
            button2.setTitle("Sofia", for: UIControlState.normal)
            button3.setTitle("Athens", for: UIControlState.normal)
            button4.setTitle("Stockholm", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 26:
            
            
            let latitude:Double = 54.6871555
            let longitude:Double = 25.279651400000034
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Lituania is ...?"
            button1.setTitle("Tallin", for: UIControlState.normal)
            button2.setTitle("Riga", for: UIControlState.normal)
            button3.setTitle("Vilnius", for: UIControlState.normal)
            button4.setTitle("Helsinki", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 27:
            
            
            let latitude:Double = 48.1485965
            let longitude:Double = 17.107747700000004
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Slovakia is ...?"
            button1.setTitle("Bucharest", for: UIControlState.normal)
            button2.setTitle("Budapest", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Bratislava", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 28:
            
            
            let latitude:Double = 44.786568
            let longitude:Double = 20.44892159999995
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Serbia is ...?"
            button1.setTitle("Zurich", for: UIControlState.normal)
            button2.setTitle("Zagreb", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 29:
            
            
            let latitude:Double = 56.9496487
            let longitude:Double = 24.10518639999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Latvia is ...?"
            button1.setTitle("Warsaw", for: UIControlState.normal)
            button2.setTitle("Tallin", for: UIControlState.normal)
            button3.setTitle("Vilnius", for: UIControlState.normal)
            button4.setTitle("Riga", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 30:
            
            
            let latitude:Double = 59.9138688
            let longitude:Double = 10.752245399999993
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Norway is ...?"
            button1.setTitle("Copenhagen", for: UIControlState.normal)
            button2.setTitle("Oslo", for: UIControlState.normal)
            button3.setTitle("Stockholm", for: UIControlState.normal)
            button4.setTitle("Helsinki", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 31:
            
            
            let latitude:Double = 46.0569465
            let longitude:Double = 14.505751499999974
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Slovenia is ...?"
            button1.setTitle("Zurich", for: UIControlState.normal)
            button2.setTitle("Zagreb", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 32:
            
            
            let latitude:Double = 64.12652059999999
            let longitude:Double = -21.817439299999933
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Iceland is ...?"
            button1.setTitle("Reykjavik", for: UIControlState.normal)
            button2.setTitle("Helsinky", for: UIControlState.normal)
            button3.setTitle("Dublin", for: UIControlState.normal)
            button4.setTitle("Amsterdam", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 33:
            
            
            let latitude:Double = 44.4267674
            let longitude:Double = 26.102538399999958
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Romania is ...?"
            button1.setTitle("Budapest", for: UIControlState.normal)
            button2.setTitle("Bucharest", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Bratislava", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 34:
            
            
            let latitude:Double = 52.3702157
            let longitude:Double = 4.895167899999933
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Netherlands is ...?"
            button1.setTitle("Rotterdam", for: UIControlState.normal)
            button2.setTitle("London", for: UIControlState.normal)
            button3.setTitle("Bruxelles", for: UIControlState.normal)
            button4.setTitle("Amsterdam", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 35:
            
            
            let latitude:Double = 59.32932349999999
            let longitude:Double = 18.068580800000063
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Sweden is ...?"
            button1.setTitle("Stockholm", for: UIControlState.normal)
            button2.setTitle("Copenhagen", for: UIControlState.normal)
            button3.setTitle("Oslo", for: UIControlState.normal)
            button4.setTitle("Sarajevo", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 36:
            
            
            let latitude:Double = 60.16985569999999
            let longitude:Double = 24.93837899999994
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Finland is ...?"
            button1.setTitle("Praga", for: UIControlState.normal)
            button2.setTitle("Stockholm", for: UIControlState.normal)
            button3.setTitle("Helsinki", for: UIControlState.normal)
            button4.setTitle("Berna", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 37:
            
            
            let latitude:Double = 35.89890849999999
            let longitude:Double = 14.514552800000047
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Malta is ...?"
            button1.setTitle("Venice", for: UIControlState.normal)
            button2.setTitle("Vaduz", for: UIControlState.normal)
            button3.setTitle("Vatican", for: UIControlState.normal)
            button4.setTitle("Valleta", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 38:
            
            
            let latitude:Double = 59.43696079999999
            let longitude:Double = 24.75357459999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Estonia is ...?"
            button1.setTitle("Tallin", for: UIControlState.normal)
            button2.setTitle("Tiranna", for: UIControlState.normal)
            button3.setTitle("Tronheim", for: UIControlState.normal)
            button4.setTitle("Tiraspol", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 39:
            
            
            let latitude:Double = 41.90291599999999
            let longitude:Double = 12.453389000000016
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Vatican is ...?"
            button1.setTitle("Zagreb", for: UIControlState.normal)
            button2.setTitle("Vatican", for: UIControlState.normal)
            button3.setTitle("Podgorica", for: UIControlState.normal)
            button4.setTitle("Skopje", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 40:
            
            
            let latitude:Double = 47.0104529
            let longitude:Double = 28.86381030000007
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Moldova is ...?"
            button1.setTitle("Chisinau", for: UIControlState.normal)
            button2.setTitle("Bucharest", for: UIControlState.normal)
            button3.setTitle("Kiev", for: UIControlState.normal)
            button4.setTitle("Valletta", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 41:
            
            
            let latitude:Double = 53.3498053
            let longitude:Double = -6.260309699999993
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Ireland is ...?"
            button1.setTitle("Cardiff", for: UIControlState.normal)
            button2.setTitle("London", for: UIControlState.normal)
            button3.setTitle("Dublin", for: UIControlState.normal)
            button4.setTitle("Belfast", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 42:
            
            
            let latitude:Double = 48.85661400000001
            let longitude:Double = 2.3522219000000177
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of France is ...?"
            button1.setTitle("Marseille", for: UIControlState.normal)
            button2.setTitle("Monaco", for: UIControlState.normal)
            button3.setTitle("Paris", for: UIControlState.normal)
            button4.setTitle("Amsterdam", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 43:
            
            
            let latitude:Double = 55.6760968
            let longitude:Double = 12.568337100000008
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Denmark is ...?"
            button1.setTitle("Osolo", for: UIControlState.normal)
            button2.setTitle("Copenhagen", for: UIControlState.normal)
            button3.setTitle("Sofia", for: UIControlState.normal)
            button4.setTitle("Ankara", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 44:
            
            
            let latitude:Double = 38.7222524
            let longitude:Double = -9.139336599999979
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Portugal is ...?"
            button1.setTitle("Porto", for: UIControlState.normal)
            button2.setTitle("Lisbon", for: UIControlState.normal)
            button3.setTitle("Madrid", for: UIControlState.normal)
            button4.setTitle("Bilbao", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 45:
            
            
            let latitude:Double = 46.9479739
            let longitude:Double = 7.447446799999966
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Swizerland is ...?"
            button1.setTitle("Brasov", for: UIControlState.normal)
            button2.setTitle("Bratislava", for: UIControlState.normal)
            button3.setTitle("Belgrade", for: UIControlState.normal)
            button4.setTitle("Bern", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 46:
            
            
            let latitude:Double = 37.9838096
            let longitude:Double = 23.727538800000048
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Greece is ...?"
            button1.setTitle("Ankara", for: UIControlState.normal)
            button2.setTitle("Athens", for: UIControlState.normal)
            button3.setTitle("Thesaloniki", for: UIControlState.normal)
            button4.setTitle("Viena", for: UIControlState.normal)
            
            correctAnswer = "2"
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
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
                
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
               
            }
            if countQuestions == 46 {
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
            
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
                
            }
            if countQuestions == 46 {
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

            
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
               
            }
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
                
            }
            if countQuestions == 46 {
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
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
               
            }
            
            if correctAnswer == "1" {
                button1.backgroundColor = UIColor.green
               
            }
            if countQuestions == 46 {
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
        countQuestionsLabel.text = String("Q: \(countQuestions)/46")
       
        
        
        
       
    }
    
    
    
    
    @IBAction func finishButton(_ sender: Any) {
        
       randomQuestionArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]
        
        livesNumber = 3
        countQuestions = 1
        
       livesLabel.text = String("Lives: \(livesNumber)")
        countQuestionsLabel.text = String("Q: \(countQuestions)/46")
        
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

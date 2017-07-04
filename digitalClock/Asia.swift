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


class Asia: UIViewController, CLLocationManagerDelegate {
    
    
    
    
    
    
    
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
    var randomQuestionArray:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43]
    
    
    var livesNumber:Int = 3
    var countQuestions:Int = 1
    
    var manager = CLLocationManager()
    
   
    
    var latitudeSlovenia:Double = 46.15124099999999
    var longitudeSlovenia:Double = 14.995462999999972
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        button1.layer.cornerRadius = 20
        button2.layer.cornerRadius = 20
        button3.layer.cornerRadius = 20
        button4.layer.cornerRadius = 20
        
        nextQuestionOutlet.isHidden = true
        
        nextQuestionOutlet.layer.cornerRadius = 15
        
        countQuestionsLabel.text = "Q: 1/43"
        
        
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
        
        if countQuestions == 43 && livesNumber > 0 {
            
            
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
        
        if countQuestions > 43 {
            countQuestions = 43
        }
        
        countQuestionsLabel.text = String("Q: \(countQuestions)/43")
        
        
        
    }
    
   
    func removeAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        
    }
    
    
    
    func randomQuestions() {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomQuestionArray.count)))
        
        
        if randomQuestionArray.count > 0 {
            
        
        
        
        
        switch(randomQuestionArray[randomIndex]) {
            
        case 1:
            
            
            let latitude:Double = 34.5553494
            let longitude:Double = 69.20748600000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)

            
            
            
            
            
            questionLabel.text = "The capital of Afganistan is ..."
            button1.setTitle("Astana", for: UIControlState.normal)
            button2.setTitle("Kabul", for: UIControlState.normal)
            button3.setTitle("Tibilisi", for: UIControlState.normal)
            button4.setTitle("Amman", for: UIControlState.normal)
            
            correctAnswer = "2"
    
            break
        case 2:
            
            
            let latitude:Double = 26.2285161
            let longitude:Double = 50.58604969999999
            
            let span = MKCoordinateSpanMake(55, 55)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            questionLabel.text = "The capital of Bahrain is ..."
            button1.setTitle("Vientiane", for: UIControlState.normal)
            button2.setTitle("Amman", for: UIControlState.normal)
            button3.setTitle("Madeira", for: UIControlState.normal)
            button4.setTitle("Manama", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 3:
            
            let latitude:Double = 23.810332
            let longitude:Double = 90.41251809999994
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Bangladesh is ...?"
            button1.setTitle("Dhaka", for: UIControlState.normal)
            button2.setTitle("Baku", for: UIControlState.normal)
            button3.setTitle("Bishkek", for: UIControlState.normal)
            button4.setTitle("Jakarta", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 4:
            
            
            let latitude:Double = 27.514162
            let longitude:Double = 90.43360099999995
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Bhutan is ...?"
            button1.setTitle("Kabul", for: UIControlState.normal)
            button2.setTitle("Thimpu", for: UIControlState.normal)
            button3.setTitle("Dubai", for: UIControlState.normal)
            button4.setTitle("Podgorica", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 5:
            
            let latitude:Double = 4.535277000000001
            let longitude:Double = 114.72766899999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Brunei is ...?"
            button1.setTitle("Tyraspol", for: UIControlState.normal)
            button2.setTitle("Bandar Seri Begawan", for: UIControlState.normal)
            button3.setTitle("Dhaka", for: UIControlState.normal)
            button4.setTitle("Thimphu", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 6:
            
            
            let latitude:Double = 12.565679
            let longitude:Double = 104.99096299999997
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Cambodia is ...?"
            button1.setTitle("Muscat", for: UIControlState.normal)
            button2.setTitle("Taipei", for: UIControlState.normal)
            button3.setTitle("Damascus", for: UIControlState.normal)
            button4.setTitle("Phnom Penh", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 7:
            
            
            let latitude:Double = 39.90419989999999
            let longitude:Double = 116.40739630000007
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of China is ...?"
            button1.setTitle("Tehran", for: UIControlState.normal)
            button2.setTitle("Tibilisi", for: UIControlState.normal)
            button3.setTitle("Beijing", for: UIControlState.normal)
            button4.setTitle("Bangkok", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 8:
            
            
            let latitude:Double = 20.593684
            let longitude:Double = 78.96288000000004
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of India is ...?"
            button1.setTitle("Bangore", for: UIControlState.normal)
            button2.setTitle("Dushanbe", for: UIControlState.normal)
            button3.setTitle("New Delhi", for: UIControlState.normal)
            button4.setTitle("Vaduz", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 9:
            
            
            let latitude:Double = -6.17511
            let longitude:Double = 106.86503949999997
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Indonesia is ...?"
            button1.setTitle("Kuala Lumpur", for: UIControlState.normal)
            button2.setTitle("Bern", for: UIControlState.normal)
            button3.setTitle("Jakarta", for: UIControlState.normal)
            button4.setTitle("Riyad", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
            
        case 11:
            
            
            let latitude:Double = 35.6891975
            let longitude:Double = 51.388973599999986
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Iran is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Tehran", for: UIControlState.normal)
            button3.setTitle("Kabul", for: UIControlState.normal)
            button4.setTitle("Baghdad", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 12:
            
            
            let latitude:Double = 33.3128057
            let longitude:Double = 44.36148750000007
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Iraq is ...?"
            button1.setTitle("Istambul", for: UIControlState.normal)
            button2.setTitle("Baghdad", for: UIControlState.normal)
            button3.setTitle("Baku", for: UIControlState.normal)
            button4.setTitle("Tehran", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 13:
            
            
            let latitude:Double = 31.768319
            let longitude:Double = 35.21370999999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Israel is ...?"
            button1.setTitle("Tibilisi", for: UIControlState.normal)
            button2.setTitle("Erevan", for: UIControlState.normal)
            button3.setTitle("Tel aviv", for: UIControlState.normal)
            button4.setTitle("Jerusalem", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 14:
            
            
            let latitude:Double = 35.6894875
            let longitude:Double = 139.69170639999993
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Japan is ...?"
            button1.setTitle("Doha", for: UIControlState.normal)
            button2.setTitle("Dushanbe", for: UIControlState.normal)
            button3.setTitle("Tokio", for: UIControlState.normal)
            button4.setTitle("Beijing", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 15:
            
            
            let latitude:Double = 31.9453666
            let longitude:Double = 35.92837159999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Jordan is ...?"
            button1.setTitle("Amman", for: UIControlState.normal)
            button2.setTitle("Muscat", for: UIControlState.normal)
            button3.setTitle("Vientiane", for: UIControlState.normal)
            button4.setTitle("Beirut", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

            
        case 16:
            
            
            let latitude:Double = 51.1605227
            let longitude:Double = 71.4703558
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Kazahstan is ...?"
            button1.setTitle("Beirut", for: UIControlState.normal)
            button2.setTitle("Astana", for: UIControlState.normal)
            button3.setTitle("Taipei", for: UIControlState.normal)
            button4.setTitle("Bishkek", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 17:
            
            
            let latitude:Double = 40.339852
            let longitude:Double = 127.51009299999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of North Korea is ...?"
            button1.setTitle("Jakarta", for: UIControlState.normal)
            button2.setTitle("Ulaanbaatar", for: UIControlState.normal)
            button3.setTitle("Seoul", for: UIControlState.normal)
            button4.setTitle("Pyongyang", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 18:
            
            
            let latitude:Double = 35.90775699999999
            let longitude:Double = 127.76692200000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of South Korea is ...?"
            button1.setTitle("Bangkok", for: UIControlState.normal)
            button2.setTitle("Zagreb", for: UIControlState.normal)
            button3.setTitle("Seoul", for: UIControlState.normal)
            button4.setTitle("Pyongyang", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 19:
            
            
            let latitude:Double = 29.375859
            let longitude:Double = 47.97740520000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Kuwait is ...?"
            button1.setTitle("Warsaw", for: UIControlState.normal)
            button2.setTitle("Dushanbe", for: UIControlState.normal)
            button3.setTitle("Dubai", for: UIControlState.normal)
            button4.setTitle("Kuwait City", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 20:
            
            
            let latitude:Double = 41.20438
            let longitude:Double = 74.76609800000006
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Krgyzstan is ...?"
            button1.setTitle("Bishkek", for: UIControlState.normal)
            button2.setTitle("Tirana", for: UIControlState.normal)
            button3.setTitle("Kabul", for: UIControlState.normal)
            button4.setTitle("Muscat", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

            
        case 21:
            
            
            let latitude:Double = 19.85627
            let longitude:Double = 102.495496
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Laos is ...?"
            button1.setTitle("Hanoi", for: UIControlState.normal)
            button2.setTitle("Vientiane", for: UIControlState.normal)
            button3.setTitle("Sana'a", for: UIControlState.normal)
            button4.setTitle("Abu Dhabi", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 22:
            
            
            let latitude:Double = 33.8937913
            let longitude:Double = 35.50177669999994
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Lebanon is ...?"
            button1.setTitle("Abu Dhabi", for: UIControlState.normal)
            button2.setTitle("Belgrade", for: UIControlState.normal)
            button3.setTitle("Beirut", for: UIControlState.normal)
            button4.setTitle("Ankara", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

            
        case 23:
            
            
            let latitude:Double = 3.139003
            let longitude:Double = 101.68685499999992
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Malaysia is ...?"
            button1.setTitle("Bratislava", for: UIControlState.normal)
            button2.setTitle("Sana'a", for: UIControlState.normal)
            button3.setTitle("Beirut", for: UIControlState.normal)
            button4.setTitle("Kuala Lumpur", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 24:
            
            
            let latitude:Double = 1.9772276
            let longitude:Double = 73.53610100000003
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Maldives is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Doha", for: UIControlState.normal)
            button3.setTitle("Hanoi", for: UIControlState.normal)
            button4.setTitle("Ljubiana", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 25:
            
            
            let latitude:Double = 47.88639879999999
            let longitude:Double = 106.90574390000006
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Mongolia is ...?"
            button1.setTitle("Ulaanbaatar", for: UIControlState.normal)
            button2.setTitle("Hanoi", for: UIControlState.normal)
            button3.setTitle("Damscus", for: UIControlState.normal)
            button4.setTitle("Manila", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 26:
            
            
            let latitude:Double = 21.916221
            let longitude:Double = 95.95597399999997
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Myanmar is ...?"
            button1.setTitle("Tallin", for: UIControlState.normal)
            button2.setTitle("Bishkek", for: UIControlState.normal)
            button3.setTitle("Napydaw", for: UIControlState.normal)
            button4.setTitle("Ashgabat", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 27:
            
            
            let latitude:Double = 27.7172453
            let longitude:Double = 85.3239605
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Nepal is ...?"
            button1.setTitle("Bucharest", for: UIControlState.normal)
            button2.setTitle("Riyadh", for: UIControlState.normal)
            button3.setTitle("Taipei", for: UIControlState.normal)
            button4.setTitle("Kathmandu", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
            
        case 28:
            
            
            let latitude:Double = 23.58589
            let longitude:Double = 58.40592270000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Oman is ...?"
            button1.setTitle("Kathmandu", for: UIControlState.normal)
            button2.setTitle("Islamabad", for: UIControlState.normal)
            button3.setTitle("Muscat", for: UIControlState.normal)
            button4.setTitle("Vientiane", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 29:
            
            
            let latitude:Double = 33.7293882
            let longitude:Double = 73.09314610000001
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Pakistan is ...?"
            button1.setTitle("Ankara", for: UIControlState.normal)
            button2.setTitle("Tashkent", for: UIControlState.normal)
            button3.setTitle("Hanoi", for: UIControlState.normal)
            button4.setTitle("Islamabad", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

            
        case 30:
            
            
            let latitude:Double = 14.5995124
            let longitude:Double = 120.9842195
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Philippines is ...?"
            button1.setTitle("Sana'a", for: UIControlState.normal)
            button2.setTitle("Manila", for: UIControlState.normal)
            button3.setTitle("Bishkek", for: UIControlState.normal)
            button4.setTitle("Beirut", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 31:
            
            
            let latitude:Double = 25.354826
            let longitude:Double = 51.183884000000035
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Qatar is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Dushanbe", for: UIControlState.normal)
            button3.setTitle("Dubai", for: UIControlState.normal)
            button4.setTitle("Doha", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 32:
            
            
            let latitude:Double = 24.7135517
            let longitude:Double = 46.67529569999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Saudi Arabia is ...?"
            button1.setTitle("Riyadh", for: UIControlState.normal)
            button2.setTitle("Helsinky", for: UIControlState.normal)
            button3.setTitle("Muscat", for: UIControlState.normal)
            button4.setTitle("Hanoi", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 33:
            
            
            let latitude:Double = 1.3553794
            let longitude:Double = 103.86774439999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Singapore is ...?"
            button1.setTitle("Sana'a", for: UIControlState.normal)
            button2.setTitle("Singapore", for: UIControlState.normal)
            button3.setTitle("New Delhi", for: UIControlState.normal)
            button4.setTitle("Doha", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 34:
            
            
            let latitude:Double = 7.873053999999999
            let longitude:Double = 80.77179699999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Sri Lanka is ...?"
            button1.setTitle("Kuala Lumpur", for: UIControlState.normal)
            button2.setTitle("Ashgabat", for: UIControlState.normal)
            button3.setTitle("Tashkent", for: UIControlState.normal)
            button4.setTitle("Sri Jayawardenapura", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 35:
            
            
            let latitude:Double = 33.5138073
            let longitude:Double = 36.27652790000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Syria is ...?"
            button1.setTitle("Damascus", for: UIControlState.normal)
            button2.setTitle("Abu dhabi", for: UIControlState.normal)
            button3.setTitle("Kathmandu", for: UIControlState.normal)
            button4.setTitle("Doha", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 36:
            
            
            let latitude:Double = 25.0329636
            let longitude:Double = 121.56542680000007
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Taiwan is ...?"
            button1.setTitle("Beijing", for: UIControlState.normal)
            button2.setTitle("Muscat", for: UIControlState.normal)
            button3.setTitle("Taipei", for: UIControlState.normal)
            button4.setTitle("Manila", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 37:
            
            
            let latitude:Double = 37.9600766
            let longitude:Double = 58.32606290000001
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Tajikistan is ...?"
            button1.setTitle("Taipei", for: UIControlState.normal)
            button2.setTitle("Vaduz", for: UIControlState.normal)
            button3.setTitle("Ashgabat", for: UIControlState.normal)
            button4.setTitle("Dushanbe", for: UIControlState.normal)
            
            correctAnswer = "4"
            break

        case 38:
            
            
            let latitude:Double = 13.7563309
            let longitude:Double = 100.50176510000006
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Thailand is ...?"
            button1.setTitle("Bangkok", for: UIControlState.normal)
            button2.setTitle("Tiranna", for: UIControlState.normal)
            button3.setTitle("Ankara", for: UIControlState.normal)
            button4.setTitle("Taipei", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 39:
            
            
            let latitude:Double = 38.969719
            let longitude:Double = 59.55627800000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Turkmenistan is ...?"
            button1.setTitle("Dushanbe", for: UIControlState.normal)
            button2.setTitle("Ashgabat", for: UIControlState.normal)
            button3.setTitle("Podgorica", for: UIControlState.normal)
            button4.setTitle("Muscat", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 40:
            
            
            let latitude:Double = 23.424076
            let longitude:Double = 53.84781799999996
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of UAE is ...?"
            button1.setTitle("Abu Dhabi", for: UIControlState.normal)
            button2.setTitle("Doha", for: UIControlState.normal)
            button3.setTitle("Riyadh", for: UIControlState.normal)
            button4.setTitle("Valletta", for: UIControlState.normal)
            
            correctAnswer = "1"
            break

        case 41:
            
            
            let latitude:Double = 41.377491
            let longitude:Double = 64.58526200000006
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Uzbekistan is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Doha", for: UIControlState.normal)
            button3.setTitle("Tashkent", for: UIControlState.normal)
            button4.setTitle("Ashgabat", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 42:
            
            
            let latitude:Double = 21.0277644
            let longitude:Double = 105.83415979999995
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Vietnam is ...?"
            button1.setTitle("Beirut", for: UIControlState.normal)
            button2.setTitle("Doha", for: UIControlState.normal)
            button3.setTitle("Hanoi", for: UIControlState.normal)
            button4.setTitle("Bangkok", for: UIControlState.normal)
            
            correctAnswer = "3"
            break

        case 43:
            
            
            let latitude:Double = 15.552727
            let longitude:Double = 48.516388000000006
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Yemen is ...?"
            button1.setTitle("Dhaka", for: UIControlState.normal)
            button2.setTitle("Sana'a", for: UIControlState.normal)
            button3.setTitle("Sofia", for: UIControlState.normal)
            button4.setTitle("Beirut", for: UIControlState.normal)
            
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
            if countQuestions == 43 {
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
            if countQuestions == 43 {
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
            if countQuestions == 43 {
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
            if countQuestions == 43 {
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
        countQuestionsLabel.text = String("Q: \(countQuestions)/43")
       
        
        
        
       
    }
    
    
    
    
    @IBAction func finishButton(_ sender: Any) {
        
       randomQuestionArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43]
        
        livesNumber = 3
        countQuestions = 1
        
       livesLabel.text = String("Lives: \(livesNumber)")
        countQuestionsLabel.text = String("Q: \(countQuestions)/43")
        
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

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


class SouthAmerica: UIViewController, CLLocationManagerDelegate {
    
    
    
    
    
    
    
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
    var randomQuestionArray:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    
    
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
        
        countQuestionsLabel.text = "Q: 1/13"
        
        
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
        
        if countQuestions == 13 && livesNumber > 0 {
            
            
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
        
        if countQuestions > 13 {
            countQuestions = 13
        }
        
        countQuestionsLabel.text = String("Q: \(countQuestions)/13")
        
        
        
    }
    
   
    func removeAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        
    }
    
    
    
    func randomQuestions() {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomQuestionArray.count)))
        
        
        if randomQuestionArray.count > 0 {
            
        
        
        
        
        switch(randomQuestionArray[randomIndex]) {
            
        case 1:
            
            
            let latitude:Double = -34.60368440000001
            let longitude:Double = -58.381559100000004
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)

            
            
            
            
            
            questionLabel.text = "The capital of Argentina is ..."
            button1.setTitle("Lima", for: UIControlState.normal)
            button2.setTitle("Buenos Aires", for: UIControlState.normal)
            button3.setTitle("Santiago", for: UIControlState.normal)
            button4.setTitle("Caracas", for: UIControlState.normal)
            
            correctAnswer = "2"
    
            break
        case 2:
            
            
            let latitude:Double = -16.489689
            let longitude:Double = -68.11929359999999
            
            let span = MKCoordinateSpanMake(55, 55)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            questionLabel.text = "The capital of Bolivia is ..."
            button1.setTitle("Quito", for: UIControlState.normal)
            button2.setTitle("Montevideo", for: UIControlState.normal)
            button3.setTitle("Madeira", for: UIControlState.normal)
            button4.setTitle("La paz", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 3:
            
            let latitude:Double = -15.7942287
            let longitude:Double = -47.882165799999996
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
           
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Brazil is ...?"
            button1.setTitle("Brasilia", for: UIControlState.normal)
            button2.setTitle("Rio de Janeiro", for: UIControlState.normal)
            button3.setTitle("Cordoba", for: UIControlState.normal)
            button4.setTitle("Sao Paolo", for: UIControlState.normal)
            
            correctAnswer = "1"
            break
        case 4:
            
            
            let latitude:Double = -33.4378305
            let longitude:Double = -70.65044920000003
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Chile is ...?"
            button1.setTitle("Buenos Aires", for: UIControlState.normal)
            button2.setTitle("Santiago", for: UIControlState.normal)
            button3.setTitle("Quito", for: UIControlState.normal)
            button4.setTitle("Paramaribo", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 5:
            
            let latitude:Double = 4.710988599999999
            let longitude:Double = -74.072092
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Columbia is ...?"
            button1.setTitle("Quito", for: UIControlState.normal)
            button2.setTitle("Bogota", for: UIControlState.normal)
            button3.setTitle("Georgetown", for: UIControlState.normal)
            button4.setTitle("Caracas", for: UIControlState.normal)
            
            correctAnswer = "2"
            break
        case 6:
            
            
            let latitude:Double = -0.1806532
            let longitude:Double = -78.46783820000002
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Ecuador is ...?"
            button1.setTitle("Asuncion", for: UIControlState.normal)
            button2.setTitle("Sucre", for: UIControlState.normal)
            button3.setTitle("Santiago", for: UIControlState.normal)
            button4.setTitle("Quito", for: UIControlState.normal)
            
            correctAnswer = "4"
            break
        case 7:
            
            
            let latitude:Double = 4.860416
            let longitude:Double = -58.93018000000001
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Guyana is ...?"
            button1.setTitle("Caracas", for: UIControlState.normal)
            button2.setTitle("Asuncion", for: UIControlState.normal)
            button3.setTitle("Georgetown", for: UIControlState.normal)
            button4.setTitle("Brasilia", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 8:
            
            
            let latitude:Double = -25.26373989999999
            let longitude:Double = -57.57592599999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Paraguay is ...?"
            button1.setTitle("Paramaribo", for: UIControlState.normal)
            button2.setTitle("Montevideo", for: UIControlState.normal)
            button3.setTitle("Asuncion", for: UIControlState.normal)
            button4.setTitle("Vaduz", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
        case 9:
            
            
            let latitude:Double = -12.2720956
            let longitude:Double = -76.27108329999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            questionLabel.text = "The capital of Peru is ...?"
            button1.setTitle("Bogota", for: UIControlState.normal)
            button2.setTitle("Caracas", for: UIControlState.normal)
            button3.setTitle("Lima", for: UIControlState.normal)
            button4.setTitle("Riyad", for: UIControlState.normal)
            
            correctAnswer = "3"
            break
            
        case 11:
            
            
            let latitude:Double = 5.852035499999999
            let longitude:Double = -55.2038278
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Suriname is ...?"
            button1.setTitle("Male", for: UIControlState.normal)
            button2.setTitle("Paramaribo", for: UIControlState.normal)
            button3.setTitle("Georgetown", for: UIControlState.normal)
            button4.setTitle("Santiago", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

        case 12:
            
            
            let latitude:Double = -34.9011127
            let longitude:Double = -56.16453139999999
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Uruguay is ...?"
            button1.setTitle("Asuncion", for: UIControlState.normal)
            button2.setTitle("Montevideo", for: UIControlState.normal)
            button3.setTitle("Guyana", for: UIControlState.normal)
            button4.setTitle("Lima", for: UIControlState.normal)
            
            correctAnswer = "2"
            break

            
        case 13:
            
            
            let latitude:Double = 10.4805937
            let longitude:Double = -66.90360629999998
            
            let span = MKCoordinateSpanMake(36, 36)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            
            mapView.setRegion(region, animated: true)
            
            let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let objectAnn = MKPointAnnotation()
            objectAnn.coordinate = pinLocation
            
            self.mapView.addAnnotation(objectAnn)
            
            
            
            
            
            questionLabel.text = "The capital of Venezuela is ...?"
            button1.setTitle("Asuncion", for: UIControlState.normal)
            button2.setTitle("Quito", for: UIControlState.normal)
            button3.setTitle("Lima", for: UIControlState.normal)
            button4.setTitle("Caracas", for: UIControlState.normal)
            
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
            
            if correctAnswer == "2" {
                button2.backgroundColor = UIColor.green
                
                
            }
            
            if correctAnswer == "3" {
                button3.backgroundColor = UIColor.green
                
            }
            
            if correctAnswer == "4" {
                button4.backgroundColor = UIColor.green
               
            }
            if countQuestions == 13 {
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
            if countQuestions == 13 {
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
            if countQuestions == 13 {
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
            if countQuestions == 13 {
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
        countQuestionsLabel.text = String("Q: \(countQuestions)/13")
       
        
        
        
       
    }
    
    
    
    
    @IBAction func finishButton(_ sender: Any) {
        
       randomQuestionArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        
        livesNumber = 3
        countQuestions = 1
        
       livesLabel.text = String("Lives: \(livesNumber)")
        countQuestionsLabel.text = String("Q: \(countQuestions)/13")
        
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

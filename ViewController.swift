//
//  ViewController.swift
//  digitalClock
//
//  Created by Admin on 28/06/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var topImageView: UIImageView!
    
    
    
    @IBAction func presentScene(_ sender: Any)
    {
        
        performSegue(withIdentifier: names[p], sender: self)
     
    }
    
    
    
    @IBAction func presentScene2(_ sender: Any)
    {
        performSegue(withIdentifier: names[p], sender: self)
    }
    
    
    
    
    
    @IBOutlet var bottomImageView: UIImageView!
    
    
    
    @IBOutlet var tableViewMy: UITableView!
    
    
    @IBAction func switchCustomTableViewAction(_ sender: UISegmentedControl)
    {
        p = sender.selectedSegmentIndex
        tableViewMy.reloadData()
        
        
        
    }
    
    
    
   
    
    var names = [ "landscapeEurope","landscapeAsia","landscapeUsa","landscapeAmazon"]
    
    var names2 = ["double1", "double2", "double3", "double4"]
    
    var p: Int!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellMy", for: indexPath) as! customCell
        

    cell.myImage.image = UIImage(named: names[p] + ".jpg")
        UIView.transition(with: cell.myImage, duration: 0.3, options: [.transitionCurlDown], animations: {
            cell.myImage.image = UIImage(named: self.names[self.p] + ".jpg")
            
            
            
            
        })
     
        cell.myImage2.image = UIImage(named: names2[p] + ".jpg")
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMy.delegate = self
        tableViewMy.dataSource = self
        
        p = 0
        
         let newLayer = CAGradientLayer()
        newLayer.colors = [ UIColor.red.cgColor, UIColor.blue.cgColor]
        newLayer.frame = topImageView.frame
        
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        topImageView.layer.addSublayer(newLayer)
        
        
        
        
        
      
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}

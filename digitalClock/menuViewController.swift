//
//  menuViewController.swift
//  digitalClock
//
//  Created by Admin on 19/02/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit






class menuViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @IBAction func show(_ sender: Any) {
        
        performSegue(withIdentifier: "da", sender: self)
    }
    
    
   

   
}

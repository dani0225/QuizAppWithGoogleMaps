//
//  ViewController22.swift
//  digitalClock
//
//  Created by Admin on 28/06/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class ViewController22: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    
    
    let array = ["afr2"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPrototipe", for: indexPath) as! viewController22TableViewCell
        
         cell.myImage.image = UIImage(named: array[indexPath.row] + ".jpg")
        
        return (cell)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

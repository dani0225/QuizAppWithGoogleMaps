//
//  ViewController.swift
//  digitalClock
//
//  Created by Admin on 28/06/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var tableViewMy: UITableView!
    
    
    var names = ["Africa"]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellMy", for: indexPath) as! customCell
        
    cell.nameTitleLabel.text = names[indexPath.row]
    cell.myImage.image = UIImage(named: "aaf.jpg")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMy.delegate = self
        tableViewMy.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}

//
//  customCell.swift
//  digitalClock
//
//  Created by Admin on 28/06/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    
   
    @IBOutlet var myImage: UIImageView!
    
    
    @IBOutlet var myImage2: UIImageView!
    

    func setup(image: UIImage)
    {
        self.myImage.image = image
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}

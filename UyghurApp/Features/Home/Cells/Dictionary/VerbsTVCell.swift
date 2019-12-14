//
//  VerbsTVCell.swift
//  UyghurApp
//
//  Created by Mairambek on 11/21/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class VerbsTVCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let image = UIImage(named: "ic_checkmark")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:8, height: 12));
        checkmark.image = image
        accessoryView = checkmark
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

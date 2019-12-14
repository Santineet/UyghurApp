//
//  DictCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class DictCell: UITableViewCell {

    @IBOutlet weak var dictCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let image = UIImage(named: "ic_checkmark")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:8, height: 12));
        checkmark.image = image
        accessoryView = checkmark
        
        dictCategoryLabel.textColor = UIColor(red: 0.125, green: 0.231, blue: 0.306, alpha: 1)
        dictCategoryLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08

        dictCategoryLabel.attributedText = NSMutableAttributedString(string: "Text Tone", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

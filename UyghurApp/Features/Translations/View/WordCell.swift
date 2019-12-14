//
//  WordCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var formatedWords: UILabel!
    
    var translation: Translation? {
        didSet {
            self.word.text = translation?.russian_word
            self.formatedWords.text = "1) \(translation!.cyrillic_word)" + "   2) \(translation!.latin_word)" + "   3) \(translation!.arab_word)"
        }
    }
    
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

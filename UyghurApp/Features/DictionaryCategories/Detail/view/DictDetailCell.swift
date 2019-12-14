//
//  DictDetailCell.swift
//  UyghurApp
//
//  Created by Avazbek Kodiraliev on 11/22/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

import UIKit

class DictDetailCell: UITableViewCell {
    
    @IBOutlet weak var russianWord: UILabel!
    @IBOutlet weak var uyghurWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        russianWord.textColor = UIColor(red: 0.125, green: 0.231, blue: 0.306, alpha: 1)
        russianWord.font = UIFont(name: "SFProText-Regular", size: 17)
        let russianWordParagraphStyle = NSMutableParagraphStyle()
        russianWordParagraphStyle.lineHeightMultiple = 1.08
        
        russianWord.attributedText = NSMutableAttributedString(string: "New Voicemail - dictLabel", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: russianWordParagraphStyle])
        russianWord.textAlignment = .right
        
        uyghurWord.textColor = UIColor(red: 0.125, green: 0.231, blue: 0.306, alpha: 1)
        uyghurWord.font = UIFont(name: "SFProText-Regular", size: 17)
        let uyghurWordParagraphStyle = NSMutableParagraphStyle()
        uyghurWordParagraphStyle.lineHeightMultiple = 1.08
        
        uyghurWord.attributedText = NSMutableAttributedString(string: "New Voicemail - dictLabel", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: uyghurWordParagraphStyle])
        uyghurWord.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

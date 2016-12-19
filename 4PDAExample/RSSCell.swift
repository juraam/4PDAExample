//
//  RSSCell.swift
//  4PDAExample
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class RSSCell: UITableViewCell {

    static let cellHeight: CGFloat = 129
    static let textHeight: CGFloat = 73
    
    static var _testCell: RSSCell?
    static var testCell: RSSCell {
        get {
            if _testCell != nil {
                return _testCell!
            }
            _testCell = Bundle.main.loadNibNamed("RSSCell", owner: self, options: nil)![0] as! RSSCell
            return _testCell!
        }
    }
    
    @IBOutlet weak var creatorDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func  heightForText(text: String) -> CGFloat {
        testCell.descriptionTextView.text = text
        let sizeThatFitsTextView = testCell.descriptionTextView.sizeThatFits(CGSize(width: testCell.descriptionTextView.frame.size.width, height: CGFloat(MAXFLOAT)))
        
        return (cellHeight - textHeight)  + sizeThatFitsTextView.height
    }

}

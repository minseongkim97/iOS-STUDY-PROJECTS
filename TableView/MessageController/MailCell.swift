//
//  MailCell.swift
//  TableView
//
//  Created by MIN SEONG KIM on 2021/05/09.
//

import UIKit

class MailCell: UITableViewCell {

    @IBOutlet weak var nameNumber: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

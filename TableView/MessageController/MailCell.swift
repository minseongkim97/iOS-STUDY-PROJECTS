//
//  MailCell.swift
//  TableView
//
//  Created by MIN SEONG KIM on 2021/05/09.
//

import UIKit

class MailCell: UITableViewCell {

    @IBOutlet private weak var nameNumber: UILabel!
    @IBOutlet private weak var messageContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(nameNumber: String, messageContent: String) {
        self.nameNumber.text = nameNumber
        self.messageContent.text = messageContent
    }
}

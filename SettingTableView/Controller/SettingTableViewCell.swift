//
//  SettingTableViewCell.swift
//  SettingTableView
//
//  Created by MIN SEONG KIM on 2021/05/10.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconBackgroundImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconBackgroundImage.clipsToBounds = true
        iconBackgroundImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

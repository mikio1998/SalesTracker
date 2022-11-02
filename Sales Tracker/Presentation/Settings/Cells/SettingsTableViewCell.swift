//
//  SettingsTableViewCell.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/02.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImaageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(title: String, image: UIImage) {
        self.title.text = title
        self.iconImaageView.image = image
        self.selectionStyle = .none
    }
}

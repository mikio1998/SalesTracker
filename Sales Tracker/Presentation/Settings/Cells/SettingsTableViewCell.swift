//
//  SettingsTableViewCell.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/02.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var title: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setUpCell(vm: SettingsCellViewModel) {
        self.title.text = vm.title
        self.title.textColor = vm.titleTextColor
        self.iconImageView.image = vm.iconImage
        self.iconImageView.tintColor = vm.iconImageTintColor
        self.selectionStyle = .none
    }


}

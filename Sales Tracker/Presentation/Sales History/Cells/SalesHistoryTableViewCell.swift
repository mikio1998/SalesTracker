//
//  SalesHistoryTableViewCell.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import UIKit

class SalesHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadeView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell(model: SalesHistoryTableSnapshotDataModel) {
        self.selectionStyle = .none
        
        // Shade View
        shadeView.giveRoundCorners(withCornerRadius: Const.shadeViewCornerRadius)
//        shadeView.giveSmallShadow()
        shadeView.giveShadow()
        
        // Image View
        productImageView.loadImage(with: model.soldProductItem.imageUrl)
        productImageView.contentMode = .scaleAspectFit
        
        // Main View
        mainView.giveRoundCorners(withCornerRadius: Const.mainViewCornerRadius)
        mainView.clipsToBounds = true
        
        // Brand Label
        brandLabel.text = model.soldProductItem.brand
        
        // Product Label
        productLabel.text = model.soldProductItem.name
        
        // Color Label
        colorLabel.text = model.soldProductItem.color
        
        // Size Label
        sizeLabel.text = model.soldProductItem.size
        
        // Quantity Label
        quantityLabel.text = "\(model.soldProductItem.quantity)点"
    }
}

extension SalesHistoryTableViewCell {
    private enum Const {
        static let shadeViewCornerRadius: CGFloat = 8
        static let mainViewCornerRadius: CGFloat = 8
    }
}

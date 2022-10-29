//
//  ProductIndexCollectionViewCell.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/23.
//

import UIKit

class ProductIndexCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var shadeView: UIView!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(model: ProductIndexCollectionSnapshotDataModel) {
        // Shade View
        shadeView.giveRoundCorners(withCornerRadius: detailsLabel.frame.width / 10)
        shadeView.giveSmallShadow()
        
        // Details View
        detailsLabel.giveRoundCorners(withCornerRadius: detailsLabel.frame.width / 15)
        detailsLabel.layer.masksToBounds = true
        
        // Whole View
        wholeView.giveRoundCorners(withCornerRadius: 10)
        wholeView.layer.masksToBounds = true
        
        // Name Label
        productNameLabel.text = model.name
    }
}

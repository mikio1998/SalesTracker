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

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(model: ProductIndexCollectionSnapshotDataModel) {
        // Shade View
        shadeView.giveRoundCorners(withCornerRadius: detailsLabel.frame.width / Const.shadeViewCornerRaidusDivisor)
        shadeView.giveSmallShadow()

        // Image View
        guard let url = model.variants.first?.url else { return }
        productImageView.loadImage(with: url)
        productImageView.contentMode = .scaleAspectFit

        // Details View
        detailsLabel.giveRoundCorners(withCornerRadius: detailsLabel.frame.width / Const.detailsLabelCornerRaidusDivisor)
        detailsLabel.layer.masksToBounds = true

        // Whole View
        wholeView.giveRoundCorners(withCornerRadius: Const.wholeViewCornerRaidus)
        wholeView.layer.masksToBounds = true

        // Name Label
        productNameLabel.text = model.name
    }
}

extension ProductIndexCollectionViewCell {
    private enum Const {
        static let shadeViewCornerRaidusDivisor: CGFloat = 10
        static let wholeViewCornerRaidus: CGFloat = 10
        static let detailsLabelCornerRaidusDivisor: CGFloat = 20
    }
}

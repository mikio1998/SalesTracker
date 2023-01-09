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
    @IBOutlet weak var skuLabel: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: SalesHistoryCellViewModel? {
        didSet {
            guard let item = cellViewModel?.soldProductItem else { return }

            // Image View
            productImageView.loadImage(with: item.prod.url)

            // Brand label
            brandLabel.text = item.prod.vendor

            // Product Label
            productLabel.text = item.prod.name

            // Color Label
            colorLabel.text = item.prod.color

            // Size Label
            sizeLabel.text = item.prod.size

            // Quantity Label
            quantityLabel.text = "\(item.quantity)点"

            // SKU Label
            skuLabel.text = item.prod.sku
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func initView() {
        self.selectionStyle = .none

        // Shade View
        shadeView.giveRoundCorners(withCornerRadius: Const.shadeViewCornerRadius)
        shadeView.giveShadow()

        // Image View
        productImageView.contentMode = .scaleAspectFit

        // Main View
        mainView.giveRoundCorners(withCornerRadius: Const.mainViewCornerRadius)
        mainView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        brandLabel.text = nil
        productLabel.text = nil
        colorLabel.text = nil
        sizeLabel.text = nil
        quantityLabel.text = nil
    }
}

extension SalesHistoryTableViewCell {
    private enum Const {
        static let shadeViewCornerRadius: CGFloat = 8
        static let mainViewCornerRadius: CGFloat = 8
    }
}

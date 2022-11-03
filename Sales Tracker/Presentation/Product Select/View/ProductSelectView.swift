//
//  ProductSelectView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/25.
//
//https://github.com/aivars/SlideOverTutorial/blob/master/SlideOverTutorial/OverlayView.swift

import Foundation
import UIKit

protocol ProductSelectViewLike: ViewContainer {
    var presenterLike: ProductSelectPresenterLike? { get set }
}

final class ProductSelectView: XibView {
    weak var presenterLike: ProductSelectPresenterLike?
    private var data: ProductIndexCollectionSnapshotDataModel?
    
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceAndCodeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }
    
    @IBOutlet weak var addButton: UIView!

    init(data: ProductIndexCollectionSnapshotDataModel) {
        super.init(frame: .zero)
        self.data = data
        guard let first = data.variants.first else { return }
        self.titleLabel.text = data.name
        self.priceAndCodeLabel.text = "\(first.productNum) ｜ ¥\(data.price)"
        self.imageView.loadImage(with: first.imageUrl)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.addGestureRecognizer(panGesture)
        slideIndicator.roundCorners(for: .allCorners, radius: Const.slideIndicatorCornerRadius)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addButton.addGestureRecognizer(tapGesture)
        addButton.roundCorners(for: .allCorners, radius: Const.addButtonCornerRadius)
    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        // Original Y point of View.
        let y = (self.superview?.frame.height)! - self.frame.height
        
//        let translation = sender.translation(in: view)
        let translation = sender.translation(in: self)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        self.frame.origin = CGPoint(x: 0, y: y + translation.y)
        
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: self)
            if dragVelocity.y >= 1300 {
                presenterLike?.dismissPresenter(animated: true)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.frame.origin = CGPoint(x: 0, y: y)
                }
            }
        }
    }
    
    @objc func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        guard let data = data else { presenterLike?.dismissPresenter(animated: true); return }
        let colorRow: Int = pickerView.selectedRow(inComponent: Const.colorComponent)
        let sizeRow: Int = pickerView.selectedRow(inComponent: Const.sizeComponent)
        let quantityRow: Int = pickerView.selectedRow(inComponent: Const.quantityComponent)
        
        
        
        let selectedColor: String = data.variants.getNthColor(n: colorRow)
        let selectedImage: String = data.variants.getNthImg(n: colorRow)
        let selectedProductNum: String = data.variants.getNthProductNum(n: colorRow)
        let selectedSize: String = data.variants.getNthSize(n: sizeRow)
        let selectedQuantity: Int = quantityRow + 1
        
        let selectedId: String? = data.variants.searchVariantDocumentIdFor(color: selectedColor, size: selectedSize)
        let selectedBarcodes: [String] = data.variants.searchVariantBarcodesFor(color: selectedColor, size: selectedSize)

        let item: ProductItem = ProductItem(
            id: selectedId,
            brand: data.brand.officialBrandName,
            name: data.name,
            price: data.price,
            color: selectedColor,
            size: selectedSize,
            imageUrl: selectedImage,
            productNum: selectedProductNum,
            barcodes: selectedBarcodes)
        presenterLike?.didTapAddButton(item: item, quantity: selectedQuantity)
    }
}

extension ProductSelectView: UIPickerViewDataSource, UIPickerViewDelegate {
    // Color || Size || Quantity
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Const.numberOfPickerComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = data else { return 0 }
        switch component {
        case Const.colorComponent:
            return data.variants.colorCount()
        case Const.sizeComponent:
            return data.variants.sizeCount()
        case Const.quantityComponent:
            return Const.quantityCap
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = data else { return "" }
        switch component {
        case Const.colorComponent:
            return data.variants.getNthColorAndImg(n: row).color
        case Const.sizeComponent:
            return data.variants.getNthSize(n: row)
        case Const.quantityComponent:
            return "\(row+1)点"
        default:
            return "Title"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == Const.colorComponent {
            guard let url = data?.variants.getNthColorAndImg(n: row).urlString else { return }
            
            self.imageView.loadImage(with: url)
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
////        var pickerLabel = view as? UILabel
////        pickerLabel?.minimumScaleFactor = 0.5
////        return pickerLabel
//
//        var label = UILabel()
//        if let v = view as? UILabel {
//            label = v
//        }
//        label.text = "lol"
////        label.font = UIFont (name: "Helvetica Neue", size: 10)
////        label.text =  dataArray[row]
////        label.textAlignment = .center
//        label.minimumScaleFactor = 0.5
//        return label
//    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case Const.colorComponent:
            return pickerView.frame.size.width * (Const.colorComponentWidthRatio)
        default:
            return pickerView.frame.size.width * (Const.nonColorComponentWidthRatio)
        }
    }
    
}



extension ProductSelectView: ProductSelectViewLike {
}

extension ProductSelectView {
    private enum Const {
        static let slideIndicatorCornerRadius: CGFloat = 10
        static let addButtonCornerRadius: CGFloat = 10
        
        static let numberOfPickerComponents: Int = 3
        static let quantityCap: Int = 10
        static let colorComponent: Int = 0
        static let sizeComponent: Int = 1
        static let quantityComponent = 2
        
        static let colorComponentWidthRatio: CGFloat = 0.4
        static let nonColorComponentWidthRatio: CGFloat = 0.3
    }
}

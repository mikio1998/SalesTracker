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
        guard let url = data.variants.first?.imageUrl else { return }
        self.imageView.loadImage(with: url)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.addGestureRecognizer(panGesture)
        slideIndicator.roundCorners(.allCorners, radius: Const.slideIndicatorCornerRadius)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addButton.addGestureRecognizer(tapGesture)
        addButton.roundCorners(.allCorners, radius: Const.addButtonCornerRadius)
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
        let selectedColorAndImg: ColorAndURL = data.variants.getNthColorAndImg(n: pickerView.selectedRow(inComponent: Const.colorComponent))
        let selectedSize: String = data.variants.getNthSize(n: pickerView.selectedRow(inComponent: Const.sizeComponent))
        let selectedQuantity: Int = pickerView.selectedRow(inComponent: Const.quantityComponent) + 1
        let selectedId: String? = data.variants.searchVariantDocumentIdFor(color: selectedColorAndImg.color, size: selectedSize)
        let item: ProductItem = ProductItem(
            id: selectedId,
            brand: data.brand.officialBrandName,
            name: data.name,
            price: data.price,
            color: selectedColorAndImg.color,
            size: selectedSize,
            imageUrl: selectedColorAndImg.urlString)
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
            return "\(row+1)"
        default:
            return "Title"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == Const.colorComponent {
            guard let url = data?.variants[row].imageUrl else { return }
            imageView.loadImage(with: url)
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
        
        
    }
}


// TEST
//extension UIView where 

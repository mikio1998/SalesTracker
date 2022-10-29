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
        slideIndicator.roundCorners(.allCorners, radius: 10)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addButton.addGestureRecognizer(tapGesture)
        addButton.roundCorners(.allCorners, radius: 10)
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
        
        let selectedColorAndImg: ColorAndURL = data.variants.getNthColorAndImg(n: pickerView.selectedRow(inComponent: 0))
        let selectedSize: String = data.variants.getNthSize(n: pickerView.selectedRow(inComponent: 1))
        let selectedQuantity: Int = pickerView.selectedRow(inComponent: 2) + 1
        let selectedId: String? = data.variants.searchVariantDocumentIdFor(color: selectedColorAndImg.color, size: selectedSize)
        let item: ProductItem = ProductItem(
            id: selectedId,
            brand: data.brand.officialBrandName,
            name: data.name,
            price: data.price,
            color: selectedColorAndImg.color,
            size: selectedSize,
            imageUrl: selectedColorAndImg.urlString)
        Task {
            await FirestoreManager.soldAnItem(
                product: item,
                size: selectedSize,
                color: selectedColorAndImg.color,
                quantitySold: selectedQuantity,
                completion: { result in
                    switch result {
                    case .failure(let err):
                        // TODO: error alert
                        print("sold item, got err", err)
                    case .success():
                        print("wrote item success")
                    }
                })
            
        }
        presenterLike?.dismissPresenter(animated: true)
    }
}

extension ProductSelectView: UIPickerViewDataSource, UIPickerViewDelegate {
    // Color || Size || Quantity
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = data else { return 0 }
        switch component {
        case 0:
            return data.variants.colorCount()
        case 1:
            return data.variants.sizeCount()
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = data else { return "" }
        switch component {
        case 0:
            return data.variants.getNthColorAndImg(n: row).color
//            return Array(data.colors.keys)[row]
        case 1:
            return data.variants.getNthSize(n: row)
//            return data.sizes[row]
        case 2:
            return "\(row+1)"
        default:
            return "Title"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            guard let url = data?.variants[row].imageUrl else { return }
            imageView.loadImage(with: url)
        }
    }
    
}

extension ProductSelectView: ProductSelectViewLike {
}


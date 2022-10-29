//
//  EditQuantityView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import Foundation
import UIKit
import SVProgressHUD

protocol EditQuantityViewLike: ViewContainer {
    var presenterLike: EditQuantityPresenterLike? { get set }
}

final class EditQuantityView: XibView {
    weak var presenterLike: EditQuantityPresenterLike?
    
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var editButton: UIView!
    
    
    @IBAction func tapMinus(_ sender: Any) {
        guard countNum > 0 else { return }
        self.countNum -= 1
    }
    @IBAction func tapPlus(_ sender: Any) {
        self.countNum += 1
    }
    
    private var soldItem: SoldProductItem
    
    private var countNum: Int {
        didSet {
            counterLabel.text = String(countNum)
        }
    }
    
    init(soldItem: SoldProductItem) {
        self.soldItem = soldItem
        self.countNum = soldItem.quantity
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.countNum = self.soldItem.quantity
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.addGestureRecognizer(panGesture)
        slideIndicator.roundCorners(.allCorners, radius: 10)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.editButton.addGestureRecognizer(tapGesture)
        editButton.roundCorners(.allCorners, radius: 10)
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
        guard let id = soldItem.id else { return }
        SVProgressHUD.show()
        if countNum == 0 {
            FirestoreManager.deleteSaleEntry(id: id) {
                result in
                SVProgressHUD.dismiss()
                switch result {
                case .failure(let fireErr):
                    print("firerr")
                case .success(()):
                    print("success!")
                }
                self.presenterLike?.dismissPresenter(animated: true)
            }
        } else {
            FirestoreManager.updateSaleCountForItem(id: id, newCount: countNum) { result in
                SVProgressHUD.dismiss()
                switch result {
                case .failure(let fireErr):
                    // TODO: Error alert
                    print("fireerr")
                case .success(()):
                    print("Successs!")
                }
                self.presenterLike?.dismissPresenter(animated: true)
            }
        }
    }
    
}
extension EditQuantityView: EditQuantityViewLike {
    
}

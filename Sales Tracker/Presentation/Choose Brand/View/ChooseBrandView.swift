//
//  ChooseBrandView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/26.
//

import Foundation
import UIKit

protocol ChooseBrandViewLike: ViewContainer {
    var presenterLike: ChooseBrandPresenterLike? { get set }
}

final class ChooseBrandView: XibView {
    weak var presenterLike: ChooseBrandPresenterLike?
    private var pickerList: [Brand]
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }
    @IBOutlet weak var switchButton: UIView!

    init(list: [Brand]) {
        self.pickerList = list
        super.init(frame: .zero)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.addGestureRecognizer(panGesture)
        slideIndicator.roundCorners(for: .allCorners, radius: Const.slideIndicatorCornerRadius)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.switchButton.addGestureRecognizer(tapGesture)
        switchButton.roundCorners(for: .allCorners, radius: Const.switchButtonCornerRadius)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        // Original Y point of View.
        let y = (self.superview?.frame.height)! - self.frame.height
        
        let translation = sender.translation(in: self)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        self.frame.origin = CGPoint(x: 0, y: y + translation.y)
        
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: self)
            if dragVelocity.y >= 1300 {
                presenterLike?.dismissPresenter(animated: true, reloadIndexFor: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.frame.origin = CGPoint(x: 0, y: y)
                }
            }
        }
    }
    @objc func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        let selection = pickerList[pickerView.selectedRow(inComponent: 0)]
        presenterLike?.dismissPresenter(animated: true, reloadIndexFor: selection)
    }
}

extension ChooseBrandView: ChooseBrandViewLike {}

extension ChooseBrandView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Const.numberOfPickerComponents
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case Const.brandComponent:
            return pickerList.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case Const.brandComponent:
            return pickerList[row].officialBrandName
        default:
            return ""
        }
    }
}

extension ChooseBrandView {
    private enum Const {
        static let slideIndicatorCornerRadius: CGFloat = 10
        static let switchButtonCornerRadius: CGFloat = 10
        static let numberOfPickerComponents: Int = 1
        static let brandComponent: Int = 0
        
    }
}

//
//  PresentationController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/25.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
  let blurEffectView: UIVisualEffectView!
  var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
      let blurEffect = UIBlurEffect(style: .dark)
      blurEffectView = UIVisualEffectView(effect: blurEffect)
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
      tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      self.blurEffectView.isUserInteractionEnabled = true
      self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
  }

  override var frameOfPresentedViewInContainerView: CGRect {
      var heightRatio = Double()
      switch presentedViewController {
      case is ProductSelectViewController:
          heightRatio = HeightRatio.productSelect
      case is ChooseBrandViewController:
          heightRatio = HeightRatio.chooseBrand
      case is EditQuantityViewController:
          heightRatio = HeightRatio.editQuantity
      default:
          heightRatio = 0.2
      }
      return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * (1.0 - heightRatio)),
             size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
              heightRatio))
  }

  override func presentationTransitionWillBegin() {
      self.blurEffectView.alpha = 0
      self.containerView?.addSubview(blurEffectView)
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
          self.blurEffectView.alpha = 0.7
      }, completion: { _ in })
  }

  override func dismissalTransitionWillBegin() {
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
          self.blurEffectView.alpha = 0
      }, completion: { _ in
          self.blurEffectView.removeFromSuperview()
      })
  }

  override func containerViewWillLayoutSubviews() {
      super.containerViewWillLayoutSubviews()
      presentedView!.roundCorners(for: [.topLeft, .topRight], radius: 22)
  }

  override func containerViewDidLayoutSubviews() {
      super.containerViewDidLayoutSubviews()
      presentedView?.frame = frameOfPresentedViewInContainerView
      blurEffectView.frame = containerView!.bounds
  }

  @objc func dismissController() {
      self.presentedViewController.dismiss(animated: true, completion: nil)
  }
}

extension PresentationController {
    private enum HeightRatio {
        static let productSelect: Double = 0.7
        static let chooseBrand: Double = 0.4
        static let editQuantity: Double = 0.35
    }
}

//
//  XibView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

// MARK: Views inherit XibView.

import Foundation
import UIKit

class XibView: UIView {
    
    class var nibName: String {
        String(describing: self)
    }
    
    @IBOutlet private var _view: UIView! {
        didSet {
            _view.frame = bounds
            addSubview(_view)
            _view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: Self.nibName, bundle: Bundle(for: Self.self))
            .instantiate(withOwner: self, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Notes

// Inherits UIView

// "class var" ?
// Look up diff between class and static. <- **
// We're able to have view instances, with respective nibName variables with strings.
// Contexually speaking, variable nibName is owned by the instances, not the class itself (static).
// overridable var, nibName (a string describing self)
//      meaning, this nibName variable is owned by instances of the class, not by the class itself (that would be static)
//      so any instances of this class can have different nib names.
//  Important that the string var is set by describing self. So the nibName string is the same as the view class name (Needed when caching nib in memory)


// An IBOutlet view, UIView
//      name is _view to show that it is a private local variable
//    When the view is set, we set the views frame to bounds.
//    bounds describes the views location and size. Bounds by default is 0,0 and the frame is the same as the frame property.
//      https://www.hackingwithswift.com/example-code/uikit/whats-the-difference-between-frame-and-bounds
// Add this view to view
//     ...Add this "_view" to the subView of this UIView class.
//  views autosizing remask should be flexible height and width.


// override init(frame: CGrRect
//  On top of super.initing,
//  We need to prepare the nib file by caching it to memory.
//   This is done by using UINib() object (read option+click)
//   It lets us cache the contents of a nib file in memory, ready for unarchieving and instantiation.
// So essentially, we are doing this caching for the nib file with the same name as our view class.
//   MARK: (This is why they need to be the same name).

// required init?(coder: NSCoder) (vs. override init(frame: CGRect))
//required is used when view is created from storyboard/xib
// override is used when view is created programatically.

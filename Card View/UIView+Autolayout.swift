//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - Initializing & setup

    /**
     Creates a new UIView with property translatesAutoresizingMaskIntoConstraints set to false.
     */
    public class func autolayoutView() -> UIView {
        let view = UIView(withAutolayout: true)
        return view
    }

    /**
     Creates a new UIView with property translatesAutoresizingMaskIntoConstraints set to the given value.
     */
    public convenience init(withAutolayout: Bool) {
        self.init()
        self.isAutolayoutView = withAutolayout
    }

    /**
     Wrapper property for translatesAutoresizingMaskIntoConstraints.
    */
    public var isAutolayoutView: Bool {
        set {
            self.translatesAutoresizingMaskIntoConstraints = !newValue
        }
        get {
            return self.translatesAutoresizingMaskIntoConstraints
        }
    }


    // MARK: - Common constraints

    /**
     Adds constraints for centering X and Y to given view.
     */
    public func constrainTo(centerIn view: UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    /**
     Adds constraints for aligning top, bottom, leading and trailing to given view.
     */
    public func constrainTo(cover view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

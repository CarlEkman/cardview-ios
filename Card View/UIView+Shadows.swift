//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

public enum ShadowStyle: Int {
    case dropshadow
    case none
}

extension UIView {

    /**
     Applies a shadow of the given style to the view

     - parameter style: Style option for the shadow
     */
    func applyShadow(style: ShadowStyle) {

        switch style {
        case .dropshadow:
            self.layer.shadowColor = Color.Tint.shadow.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowOpacity = Effect.Shadow.opacity.float
            self.layer.shadowRadius = Effect.Shadow.radius.cgFloat
            break

        default:
            break
        }
    }

}

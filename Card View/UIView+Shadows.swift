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
            layer.shadowColor = Color.Tint.shadow.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = Effect.Shadow.opacity.float
            layer.shadowRadius = Effect.Shadow.radius.cgFloat

        default:
            break
        }
    }

}

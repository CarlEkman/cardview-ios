//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

struct Color {

    struct View {
        static let plain = UIColor(colorLiteralRed: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        static let light = UIColor(colorLiteralRed: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1.0)
        static let medium = UIColor(colorLiteralRed: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1.0)
        static let fade = UIColor(colorLiteralRed: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.2)
    }

    struct Text {
        static let main = UIColor(colorLiteralRed: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        static let medium = UIColor(colorLiteralRed: 164/255.0, green: 170/255.0, blue: 179/255.0, alpha: 1.0)
        static let light = UIColor(colorLiteralRed: 199/255.0, green: 199/255.0, blue: 205/255.0, alpha: 1.0)
    }

    struct Tint {
        static let main = UIColor(colorLiteralRed: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        static let disabled = UIColor(colorLiteralRed: 137/255.0, green: 178/255.0, blue: 205/255.0, alpha: 1.0)
        static let shadow = UIColor(colorLiteralRed: 38/255.0, green: 42/255.0, blue: 43/255.0, alpha: 1.0)
    }
    
}

struct Font {

    struct Title {
        static let medium: UIFont = UIFont.boldSystemFont(ofSize: 15)
    }

    struct Body {
        static let medium: UIFont = UIFont.systemFont(ofSize: 15)
        static let small: UIFont = UIFont.systemFont(ofSize: 12)
    }
}

struct Shape {

    struct CornerRadius {
        static let large: Double = 10.0
    }

    struct Padding {
        static let small: Double = 15.0
        static let medium: Double = 30.0
        static let large: Double = 50.0
    }

}

struct Effect {

    struct Shadow {
        static let opacity: Double = 0.1
        static let radius: Double = 4.0
    }

}

struct Time {

    struct Duration {
        static let short: Double = 0.1
        static let medium: Double = 0.2
        static let long: Double = 3.0
    }

}

extension Double {

    var cgFloat: CGFloat { return CGFloat(self) }
    var float: Float { return Float(self) }

}

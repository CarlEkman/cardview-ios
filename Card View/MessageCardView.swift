//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

class MessageCardView: CardView {

    private var title: String?
    private var message: String?

    private var didSetConstraints: Bool = false


    // MARK: - Initializer

    convenience public init(title: String?, message: String?) {
        self.init()

        self.isAutolayoutView = true

        self.title = title
        self.message = message
    }


    // MARK: - View Properties

    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel(withAutolayout: true)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Color.Text.main
        label.font = Font.Title.medium
        label.text = self.title

        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label: UILabel = UILabel(withAutolayout: true)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Color.Text.main
        label.font = Font.Body.medium
        label.text = self.message

        return label
    }()

    private lazy var blurView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectView.isAutolayoutView = true

        return effectView
    }()


    // MARK: - Autolayout

    public override func updateConstraints() {

        if (!self.didSetConstraints) {
            self.didSetConstraints = true

            let medium = Shape.Padding.medium.cgFloat
            let small = Shape.Padding.small.cgFloat

            self.addSubview(self.titleLabel)
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: medium).isActive = true
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: medium).isActive = true
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -medium).isActive = true

            self.addSubview(self.messageLabel)
            self.messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: small).isActive = true
            self.messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: medium).isActive = true
            self.messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -medium).isActive = true
            self.messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -medium).isActive = true
        }

        super.updateConstraints()
    }

    override open class var requiresConstraintBasedLayout: Bool {
        get { return true }
    }
}

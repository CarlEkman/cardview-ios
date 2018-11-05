//
//  Copyright © 2018 Carl Ekman. All rights reserved.
//

import UIKit

public class ImageCardView: CardView {

    private var image: UIImage?
    private var title: String?
    private var message: String?

    private var didSetConstraints: Bool = false


    // MARK: - Initializer

    convenience init(image: UIImage?, title: String?, message: String?) {
        self.init()
        self.image = image
        self.title = title
        self.message = message
        self.isAutolayoutView = true
    }


    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.isAutolayoutView = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel(withAutolayout: true)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Color.Text.main
        label.font = Font.Title.medium
        label.text = title

        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label: UILabel = UILabel(withAutolayout: true)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Color.Text.main
        label.font = Font.Body.medium
        label.text = message

        return label
    }()


    // MARK: - Autolayout

    public override func updateConstraints() {
        super.updateConstraints()

        if (!didSetConstraints) {
            didSetConstraints = true

            let medium = Shape.Padding.medium.cgFloat
            let small = Shape.Padding.small.cgFloat

            addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: medium).isActive = true
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: medium).isActive = true
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -medium).isActive = true

            addSubview(titleLabel)
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: small).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: medium).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -medium).isActive = true

            addSubview(messageLabel)
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: small).isActive = true
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: medium).isActive = true
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -medium).isActive = true
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -medium).isActive = true
            

        }
    }

    override open class var requiresConstraintBasedLayout: Bool {
        get { return true }
    }
}

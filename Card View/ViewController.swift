//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardViewPresenting {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.isAutolayoutView = true

        view.addSubview(testButton)
        testButton.constrainTo(centerIn: view)
    }

    private lazy var testButton: UIButton = {
        let button: UIButton  = UIButton(withAutolayout: true)
        button.setTitle(.buttonTitle, for: .normal)
        button.setTitleColor(Color.Tint.main, for: .normal)
        button.addTarget(self, action: #selector(didTapTestButton(sender:)), for: .touchUpInside)

        return button
    }()

    @objc open func didTapTestButton(sender: UIButton!) {
        let cardView = ImageCardView(image: UIImage(named: .imageName),
                                     title: .cardTitle,
                                     message: .cardText)
        self.present(cardView: cardView)
    }
}

private extension String {

    static let buttonTitle = "Tap me"
    static let imageName = "TestImage"
    static let cardTitle = "Card view"
    static let cardText = "This is a throwable modal view. Use it as an alternative to alert views."
}

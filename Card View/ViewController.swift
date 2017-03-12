//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var isPresenting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.isAutolayoutView = true

        view.addSubview(testButton)
        testButton.constrainTo(centerIn: view)
    }

    private lazy var testButton: UIButton = {
        let button: UIButton  = UIButton(withAutolayout: true)
        button.setTitle(Text.buttonTitle, for: .normal)
        button.setTitleColor(Color.Tint.main, for: .normal)
        button.addTarget(self, action: #selector(didTapTestButton(sender:)), for: .touchUpInside)

        return button
    }()

    private lazy var cardView: CardView =  {
        let cardView = MessageCardView(title: Text.cardTitle, message: Text.cardText)

        return cardView
    }()

    private lazy var fadeView: UIView = {
        let fadeView = UIView(withAutolayout: true)
        fadeView.backgroundColor = Color.View.fade
        fadeView.alpha = 0

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFadeView(sender:)))
        fadeView.addGestureRecognizer(tap)

        return fadeView
    }()


    // MARK: - User Interaction

    public func present(cardView: CardView) {
        guard !self.isPresenting else { return }

        self.addFadeView()
        cardView.present(inView: self.view, delegate: self)
        self.isPresenting = true
    }

    public func dismiss(cardView: CardView?) {
        cardView?.dismiss()
        self.removeFadeView()
        self.isPresenting = false
    }


    // MARK: - Animation

    private func addFadeView() {
        view.addSubview(fadeView)
        fadeView.constrainTo(cover: view)

        UIView.animate(withDuration: Time.Duration.medium) {
            self.fadeView.alpha = 1
        }
    }

    private func removeFadeView() {
        UIView.animate(withDuration: Time.Duration.medium, animations: {
            self.fadeView.alpha = 0
        }) { (value: Bool) in
            for subview: UIView in self.fadeView.subviews {
                subview.removeFromSuperview()
            }
            self.fadeView.removeFromSuperview()
        }
    }


    // MARK: - Actions

    @objc open func didTapTestButton(sender: UIButton!) {
        self.present(cardView: self.cardView)
    }

    @objc open func didTapFadeView(sender: UIView!) {
        self.dismiss(cardView: self.cardView)
    }

}


extension ViewController: CardViewDelegate {

    func didThrow(cardView: CardView) {
        self.dismiss(cardView: cardView)
    }

}


fileprivate struct Text {

    static let buttonTitle = "Tap me"
    static let cardTitle = "Card view"
    static let cardText = "This is a throwable modal view. Use it as an alternative to alert views."
    
}

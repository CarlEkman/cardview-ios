//
//  Copyright © 2018 Carl Ekman. All rights reserved.
//

import UIKit

public protocol CardViewPresenting {

    func present(cardView: CardView)
    func dismiss(cardView: CardView)
}

public extension CardViewPresenting where Self: UIViewController {

    func present(cardView: CardView) {
        addFadeView(for: cardView)
        cardView.present(inView: self.view) {
            self.dismiss(cardView: cardView)
        }
    }

    func dismiss(cardView: CardView) {
        cardView.dismiss()
        removeFadeView(for: cardView)
    }

    private func generateFadeView(for cardView: CardView) -> UIView {
        let fadeView = UIView(withAutolayout: true)
        fadeView.backgroundColor = Color.View.fade
        fadeView.addTapGestureRecognizer {
            self.dismiss(cardView: cardView)
        }

        return fadeView
    }

    private func addFadeView(for cardView: CardView) {
        let fadeView = generateFadeView(for: cardView)
        cardView.associatedFadeView = fadeView

        view.addSubview(fadeView)
        fadeView.constrainTo(cover: view)
        fadeView.alpha = 0

        UIView.animate(withDuration: Time.Duration.medium) {
            fadeView.alpha = 1
        }
    }

    private func removeFadeView(for cardView: CardView) {
        guard let fadeView = cardView.associatedFadeView else { return }
        cardView.associatedFadeView = nil

        UIView.animate(withDuration: Time.Duration.medium, animations: {
            fadeView.alpha = 0
        }) { (value: Bool) in
            for subview: UIView in fadeView.subviews {
                subview.removeFromSuperview()
            }
            fadeView.removeFromSuperview()
        }
    }
}

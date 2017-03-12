//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

public protocol CardViewDelegate {

    func didThrow(cardView: CardView)
}

public class CardView: UIView, UIGestureRecognizerDelegate {

    private var delegate: CardViewDelegate?
    private var animator: UIDynamicAnimator?
    private var container: UIView?

    private var attachmentBehavior: UIAttachmentBehavior!
    private var pushBehavior: UIPushBehavior!
    private var itemBehavior: UIDynamicItemBehavior!

    private var originalBounds: CGRect = CGRect.zero
    private var originalCenter: CGPoint = CGPoint.zero
    private var latestCenter: CGPoint = CGPoint.zero

    private let throwingThreshold: CGFloat = 1000
    private let throwingVelocityPadding: CGFloat = 50

    private let maximumSize: CGSize = CGSize(width: 300, height: 300)
    private let minimumSize: CGSize = CGSize(width: 100, height: 100)

    private var isDraggingCard: Bool = false
    private var didSetConstraints: Bool = false


    // MARK: - Initializers

    public init() {
        super.init(frame: CGRect.zero)

        self.isAutolayoutView = true
        self.setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    // MARK: - Setup

    private func setupView() {
        self.backgroundColor = Color.View.light
        self.clipsToBounds = true
        self.layer.cornerRadius = Shape.CornerRadius.large.cgFloat
        self.applyShadow(style: .dropshadow)

        let press = UILongPressGestureRecognizer(target: self, action: #selector(viewWasPressed(sender:)))
        press.delegate = self
        press.minimumPressDuration = 0
        self.addGestureRecognizer(press)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(viewDidPan(sender:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }


    // MARK: - Public

    public func present(inView container: UIView!, delegate: CardViewDelegate) {
        self.container = container
        self.animator = UIDynamicAnimator(referenceView: container)
        self.delegate = delegate

        container.addSubview(self)
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minimumSize.width).isActive = true
        self.widthAnchor.constraint(lessThanOrEqualToConstant: self.maximumSize.width).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumSize.height).isActive = true
        self.heightAnchor.constraint(lessThanOrEqualToConstant: self.maximumSize.width).isActive = true

        self.constrainTo(centerIn: container)
        let leading = self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Shape.Padding.large.cgFloat)
        let trailing = self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Shape.Padding.large.cgFloat)
        leading.priority = 750
        trailing.priority = 750
        leading.isActive = true
        trailing.isActive = true


        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: Time.Duration.medium, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1
        })
    }

    public func dismiss() {

        UIView.animate(withDuration: Time.Duration.medium, animations: { 
            self.alpha = 0
        }) { (finished: Bool) in
            self.removeFromSuperview()
        }
    }


    // MARK: - Gesture recognition

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc private func viewWasPressed(sender: UILongPressGestureRecognizer) {

        switch sender.state {

        case .began:
            UIView.animate(withDuration: Time.Duration.short, animations: {
                self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02);
            })

        case .cancelled:
            fallthrough

        case .ended:
            if (!self.isDraggingCard) {
                UIView.animate(withDuration: Time.Duration.short, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }

        default:
            break
        }
    }

    @objc private func viewDidPan(sender: UIPanGestureRecognizer) {

        guard let superview = self.container else { return }
        guard let animator = self.animator else { return }

        let locationInSuperview = sender.location(in: superview)
        let locationInView = sender.location(in: self)
        let centerOffset = UIOffset(horizontal: locationInView.x - self.bounds.midX, vertical: locationInView.y - self.bounds.midY)

        switch sender.state {

        case .began:

            self.isDraggingCard = true
            
            self.originalCenter = self.center
            self.originalBounds = self.bounds

            attachmentBehavior = UIAttachmentBehavior(item: self, offsetFromCenter: centerOffset, attachedToAnchor: locationInSuperview)
            animator.removeAllBehaviors()
            animator.addBehavior(attachmentBehavior)

        case .ended:

            self.isDraggingCard = false

            animator.removeAllBehaviors()
            self.center = self.latestCenter
            self.bounds = self.originalBounds

            let velocity = sender.velocity(in: superview)
            let magnitude = sqrt((velocity.x * velocity.x) + velocity.y * velocity.y)

            if magnitude > throwingThreshold {

                let direction = CGVector(dx: velocity.x / 10, dy: velocity.y / 10)

                pushBehavior = UIPushBehavior(items: [self], mode: .instantaneous)
                pushBehavior.pushDirection = direction
                pushBehavior.magnitude = magnitude / throwingVelocityPadding
                animator.addBehavior(pushBehavior)

                // Calculate angular momentum for throw.
                let radius = CGVector(dx: locationInSuperview.x - self.center.x, dy: locationInSuperview.y - self.center.y)
                let angle = (radius.dx * direction.dy - radius.dy * direction.dx) / (radius.dx * radius.dx + radius.dy * radius.dy)
                let length = sqrt(radius.dx * radius.dx + radius.dy * radius.dy)
                let dampening = CGFloat(20)

                itemBehavior = UIDynamicItemBehavior(items: [self])
                itemBehavior.friction = 0.2
                itemBehavior.allowsRotation = true
                itemBehavior.addAngularVelocity((angle * length) / dampening, for: self)
                animator.addBehavior(itemBehavior)

                DispatchQueue.main.asyncAfter(deadline: .now() + Time.Duration.medium, execute: {
                    if let delegate = self.delegate {
                        delegate.didThrow(cardView: self)
                    }
                })

            } else {

                UIView.animate(withDuration: Time.Duration.medium, animations: {
                    self.transform = CGAffineTransform.identity
                    self.center = self.originalCenter
                })
            }

        default:

            attachmentBehavior.anchorPoint = locationInSuperview
            self.latestCenter = self.center

        }
    }

}

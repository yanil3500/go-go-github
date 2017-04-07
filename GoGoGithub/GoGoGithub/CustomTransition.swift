//
//  CustomTransition.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/5/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class CustomTransition: NSObject {

    var duration: TimeInterval

    init(_ duration: TimeInterval = 0.5) {
        self.duration = duration
    }
}

// MARK: CustomTransition conforms to NSObject, UIViewControllerAnimatedTransitioning
extension CustomTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return; }

        transitionContext.containerView.addSubview(toViewController.view)

        toViewController.view.alpha = 0.0

        UIView.animate(withDuration: self.duration, animations: {

            toViewController.view.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}

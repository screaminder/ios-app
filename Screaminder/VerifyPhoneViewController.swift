//
//  VerifyPhoneViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 10/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {

    private var keyboardWillShowObserver: AnyObject!
    private var keyboardWillHideObserver: AnyObject!

    @IBOutlet weak var badge: UIImageView!

    @IBOutlet weak var verificationCodeField: UITextField!
    @IBOutlet weak var badgeTop: NSLayoutConstraint!

    override func loadView() {
        super.loadView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AuthPhoneViewController.dismiss)))
        navigationController?.setNavigationBarHidden(true, animated: false)

        verificationCodeField.layer.cornerRadius = verificationCodeField.frame.height / 2
        verificationCodeField.backgroundColor = UIColor.clearColor()
        verificationCodeField.layer.borderColor = RedColor.CGColor
        verificationCodeField.layer.borderWidth = 2.0

        verificationCodeField.attributedPlaceholder = NSAttributedString(string:"here!", attributes:[NSForegroundColorAttributeName: RedColor])
    }

    @IBAction func send(sender: AnyObject) {
        if verificationCodeField.text!.isEmpty {
            verificationCodeField.shake()
            return
        }

        verificationCodeField.resignFirstResponder()

        UIView.animateWithDuration(1.0,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.Repeat],
                                   animations: {
                                    self.badge.transform = CGAffineTransformRotate(self.badge.transform, CGFloat(M_PI))
            }, completion: nil)

        PostVerificationCode(code: verificationCodeField.text!) { success in
            if success {
                self.navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("AddContactViewController"), animated: true)
            } else {
                self.verificationCodeField.shake()
            }
            }.start()
    }

    func dismiss() {
        verificationCodeField.resignFirstResponder()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        keyboardWillShowObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) {notification in
            UIView.animateWithDuration(0.2, animations: {
                self.badgeTop.constant = -80.0
            })
        }

        keyboardWillHideObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil) {notification in
            UIView.animateWithDuration(0.2, animations: {
                self.badgeTop.constant = 50.0
            })
        }
    }

    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(keyboardWillShowObserver)
        NSNotificationCenter.defaultCenter().removeObserver(keyboardWillHideObserver)

        super.viewWillDisappear(animated)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
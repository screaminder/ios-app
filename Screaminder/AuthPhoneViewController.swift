//
//  AuthPhoneViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

class AuthPhoneViewController: UIViewController {

    private var keyboardWillShowObserver: AnyObject!
    private var keyboardWillHideObserver: AnyObject!

    @IBOutlet weak var badgeTop: NSLayoutConstraint!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    override func loadView() {
        super.loadView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AuthPhoneViewController.dismiss)))
        navigationController?.setNavigationBarHidden(true, animated: false)

        numberField.layer.cornerRadius = numberField.frame.height / 2
        numberField.backgroundColor = UIColor.clearColor()
        numberField.layer.borderColor = RedColor.CGColor
        numberField.layer.borderWidth = 2.0

        doneButton.layer.cornerRadius = 4.0
    }

    @IBAction func done(sender: AnyObject) {
        if numberField.text!.isEmpty {
            numberField.shake()
        } else {
            PostAuthPhone(number: numberField.text!).start()
        navigationController?.pushViewController(storyboard!.instantiateViewControllerWithIdentifier("AddContactViewController"), animated: true)
        }
    }

    func dismiss() {
        numberField.resignFirstResponder()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        keyboardWillShowObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) {notification in
            UIView.animateWithDuration(0.2, animations: {
                self.badgeTop.constant = -50.0
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

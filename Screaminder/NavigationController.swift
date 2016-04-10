//
//  ViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func loadView() {
        super.loadView()
        navigationBar.tintColor = GreenColor

        guard let user = UserStore.read() else {
            pushViewController(storyboard!.instantiateViewControllerWithIdentifier("AuthPhoneViewController"), animated: false)
            return
        }
        if !user.verified! {
            pushViewController(storyboard!.instantiateViewControllerWithIdentifier("VerifyPhoneViewController"), animated: false)
            return
        }

        openList()
    }

    func openList() {
        viewControllers = [storyboard!.instantiateViewControllerWithIdentifier("TodosViewController")]
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}


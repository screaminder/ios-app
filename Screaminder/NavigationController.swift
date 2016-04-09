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

        guard let _ = TokenStore.read() else {
            pushViewController(storyboard!.instantiateViewControllerWithIdentifier("AuthPhoneViewController"), animated: false)
            return
        }

        navigationBar.tintColor = GreenColor

        openList()
    }

    func openList() {
        viewControllers = [storyboard!.instantiateViewControllerWithIdentifier("TodosViewController")]
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}


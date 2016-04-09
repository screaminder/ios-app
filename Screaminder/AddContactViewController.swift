//
//  AddContactViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit
import Contacts

class AddContactViewController: UIViewController {

    @IBOutlet weak var doItButton: UIButton!
    @IBOutlet weak var head: UIImageView!

    let contactStore = AppDelegate.getAppDelegate().contactStore


    override func loadView() {
        super.loadView()

        navigationController?.setNavigationBarHidden(true, animated: false)
        doItButton.layer.cornerRadius = 4.0
    }

    @IBAction func addContact(sender: AnyObject) {
        requestForAccess { (accessGranted) in
            UIView.animateWithDuration(0.8,
                delay: 0.0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.0,
                options: .CurveEaseInOut, animations: {
                self.head.transform = CGAffineTransformMakeScale(1.3, 1.3)
                }, completion: { _ in
                    self.createContact()

                    (self.navigationController as! NavigationController).openList()
            })
        }
    }

    func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)

        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                completionHandler(accessGranted: access)
            })
        default:
            completionHandler(accessGranted: false)
        }
    }

    func createContact() {
        let newContact = CNMutableContact()

        newContact.givenName = "Eric"
        newContact.familyName = "The Screaminder"

        let number = CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: "+3726682815"))
        newContact.phoneNumbers = [number]

        newContact.imageData = UIImagePNGRepresentation(UIImage(named: "img_caller")!)

        do {
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.getAppDelegate().contactStore.executeSaveRequest(saveRequest)
        } catch {
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
}

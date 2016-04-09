//
//  AddReminderViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {

    @IBOutlet weak var reminderTitleField: UITextField!
    @IBOutlet weak var alarm: UIButton!
    @IBOutlet weak var birthday: UIButton!
    @IBOutlet weak var workout: UIButton!
    @IBOutlet weak var assignment: UIButton!

    override func loadView() {
        super.loadView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AuthPhoneViewController.dismiss)))

        selectAlarm(alarm)
    }

    @IBAction func selectAlarm(sender: AnyObject) {
        alarm.alpha = 1.0
        birthday.alpha = 0.4
        workout.alpha = 0.4
        assignment.alpha = 0.4
    }

    @IBAction func selectBirthday(sender: AnyObject) {
        alarm.alpha = 0.4
        birthday.alpha = 1.0
        workout.alpha = 0.4
        assignment.alpha = 0.4
    }

    @IBAction func selectWorkout(sender: AnyObject) {
        alarm.alpha = 0.4
        birthday.alpha = 0.4
        workout.alpha = 1.0
        assignment.alpha = 0.4
    }

    @IBAction func selectAssignment(sender: AnyObject) {
        alarm.alpha = 0.4
        birthday.alpha = 0.4
        workout.alpha = 0.4
        assignment.alpha = 1.0
    }


    func dismiss() {
        reminderTitleField.resignFirstResponder()
    }

}

//
//  AddReminderViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class AddReminderViewController: UIViewController {

    @IBOutlet weak var reminderTitleField: UITextField!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var alarm: UIButton!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthday: UIButton!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var workout: UIButton!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var assignment: UIButton!

    @IBOutlet weak var titleWrapper: UIView!
    @IBOutlet weak var titleWrapperHeight: NSLayoutConstraint!

    @IBOutlet weak var titleDescriptionLabel: UILabel!

    @IBOutlet weak var selectButton: UIButton!

    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!

    var selectedDate = NSDate()
    var selectedTime = NSDate()

    let birthdays = ["Mother",
                     "Father",
                     "Relative",
                     "Boss",
                     "Girlfriend",
                     "Boyfriend",
                     "Brother",
                     "Sister",
                     "Friend"]

    let workoutCodes = ["yoga",
                        "walking",
                        "swimming",
                        "running",
                        "martial",
                        "gym",
                        "grouptraining",
                        "teamsports"]

    let workouts = ["Yoga",
                    "Walking",
                    "Swimming",
                    "Running",
                    "Martial arts",
                    "Gym",
                    "Group training",
                    "Teamsports"]

    var type: String = ""

    var birthdaySelectedIndex = 0
    var workoutSelectedIndex = 0

    override func loadView() {
        super.loadView()

        navigationController?.navigationBar.tintColor = GreenColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AuthPhoneViewController.dismiss)))

        selectAlarm(alarm)
    }

    @IBAction func selectAlarm(sender: AnyObject) {
        type = "alarm"
        titleDescriptionLabel.text = "WHEN DO YOU NEED TO WAKE UP?"

        alarm.alpha = 1.0
        birthday.alpha = 0.4
        workout.alpha = 0.4
        assignment.alpha = 0.4

        setLabelAlphas()
        showTitle(false)
    }

    @IBAction func selectBirthday(sender: AnyObject) {
        type = "birthday"
        titleDescriptionLabel.text = "WHOS BIRTHDAY DO YOU NEED REMINDED?"

        alarm.alpha = 0.4
        birthday.alpha = 1.0
        workout.alpha = 0.4
        assignment.alpha = 0.4

        setLabelAlphas()
        showTitle(true)
        reminderTitleField.hidden = true
        selectButton.hidden = false
    }

    @IBAction func selectWorkout(sender: AnyObject) {
        type = "workout"
        titleDescriptionLabel.text = "WHOS BIRTHDAY DO YOU NEED REMINDED?"

        alarm.alpha = 0.4
        birthday.alpha = 0.4
        workout.alpha = 1.0
        assignment.alpha = 0.4

        setLabelAlphas()
        showTitle(true)
        reminderTitleField.hidden = true
        selectButton.hidden = false
    }

    @IBAction func selectAssignment(sender: AnyObject) {
        type = "custom"
        titleDescriptionLabel.text = "WHAT IS IT THAT YOU NEED ME TO REMIND YOU?"

        alarm.alpha = 0.4
        birthday.alpha = 0.4
        workout.alpha = 0.4
        assignment.alpha = 1.0

        setLabelAlphas()
        showTitle(true)
        reminderTitleField.hidden = false
        selectButton.hidden = true
    }

    func setLabelAlphas() {
        alarmLabel.alpha = alarm.alpha
        birthdayLabel.alpha = birthday.alpha
        workoutLabel.alpha = workout.alpha
        customLabel.alpha = assignment.alpha
    }

    func showTitle(show: Bool) {
        titleWrapper.hidden = !show
        titleWrapperHeight.constant = show ? 40.0 : 0.0
    }

    @IBAction func add(sender: AnyObject) {
        if reminderTitleField.text!.isEmpty && type == "custom" {
            titleWrapper.shake()
            return
        }
        if date.titleLabel!.text == "DATE" {
            date.shake()
            return
        }
        if time.titleLabel!.text == "TIME" {
            time.shake()
            return
        }
    }

    @IBAction func selectDropdown(sender: AnyObject) {
        let rows = type == "birthday" ? birthdays : workouts
        let selectedIndex = type == "birthday" ? birthdaySelectedIndex : workoutSelectedIndex

        ActionSheetStringPicker.showPickerWithTitle("Choose",
                                                    rows: rows,
                                                    initialSelection: selectedIndex,
                                                    doneBlock: { (picker, index, string) in
                                                        self.selectButton.setTitle((string as! String), forState: .Normal)
                                                        if self.type == "birthday" {
                                                            self.birthdaySelectedIndex = index
                                                        } else {
                                                            self.workoutSelectedIndex = index
                                                        }
            }, cancelBlock: nil, origin: view)
    }

    @IBAction func selectDate(sender: AnyObject) {
        ActionSheetDatePicker.showPickerWithTitle("Date", datePickerMode: UIDatePickerMode.Date, selectedDate: selectedDate, doneBlock: { (_, dateStr, _) -> Void in
            if let date = dateStr as? NSDate {
                var newDate: NSDate = NSCalendar.currentCalendar().dateBySettingUnit(.Year, value: NSCalendar.currentCalendar().component(.Year, fromDate: date), ofDate: date, options: NSCalendarOptions())!
                newDate = NSCalendar.currentCalendar().dateBySettingUnit(.Month, value: NSCalendar.currentCalendar().component(.Month, fromDate: date), ofDate: newDate, options: NSCalendarOptions())!
                newDate = NSCalendar.currentCalendar().dateBySettingUnit(.Day, value: NSCalendar.currentCalendar().component(.Day, fromDate: date), ofDate: newDate, options: NSCalendarOptions())!

                self.selectedDate = newDate

                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                self.date.setTitle(dateFormatter.stringFromDate(date), forState: .Normal)
            }
            }, cancelBlock: { (picker) -> Void in
            }, origin: self.view)
    }

    @IBAction func selectTime(sender: AnyObject) {
        ActionSheetDatePicker.showPickerWithTitle("Time", datePickerMode: UIDatePickerMode.Time, selectedDate: selectedDate, doneBlock: { (_, dateStr, _) -> Void in
            if let date = dateStr as? NSDate {
                let newDate: NSDate = NSCalendar.currentCalendar().dateBySettingHour(NSCalendar.currentCalendar().component(.Hour, fromDate: date),
                    minute: NSCalendar.currentCalendar().component(.Minute, fromDate: date),
                    second: NSCalendar.currentCalendar().component(.Second, fromDate: date),
                    ofDate: self.selectedDate,
                    options: NSCalendarOptions())!

                self.selectedDate = newDate

                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                self.time.setTitle(dateFormatter.stringFromDate(date), forState: .Normal)
            }
            }, cancelBlock: { (picker) -> Void in
            }, origin: self.view)
    }
    
    func dismiss() {
        reminderTitleField.resignFirstResponder()
    }
    
}

//
//  TodoTableViewCell.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

let PurpleColor = UIColor(red: (165.0 / 255.0), green: (76.0 / 255.0), blue: 1.0, alpha: 1.0)
let YellowColor = UIColor(red: (250.0 / 255.0), green: (232.0 / 255.0), blue: 1.0, alpha: 1.0)
let GreenColor = UIColor(red: (75.0 / 255.0), green: (181.0 / 255.0), blue: (72.0 / 255.0), alpha: 1.0)
let RedColor = UIColor(red: (221.0 / 255.0), green: (40.0 / 255.0), blue: (80.0 / 255.0), alpha: 1.0)

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!

    @IBOutlet weak var markAdDoneButton: UIButton!

    @IBOutlet weak var iconView: UIImageView!

    var doneHandler: (() -> ())?

    var todo: Todo?

    func bind(todo: Todo) {
        self.todo = todo

        titleLabel.text = todo.title.lowercaseString
        whenLabel.text = todo.time

        switch todo.type {
        case "alarm":
            titleLabel.textColor = PurpleColor
            whenLabel.textColor = PurpleColor
            iconView.image = UIImage(named: "ic_alarm")
        case "workout":
            titleLabel.textColor = UIColor.yellowColor()
            whenLabel.textColor = UIColor.yellowColor()
            iconView.image = UIImage(named: "ic_gym")
        case "birthday":
            titleLabel.textColor = GreenColor
            whenLabel.textColor = GreenColor
            iconView.image = UIImage(named: "ic_birthday")
        default:
            titleLabel.textColor = RedColor
            whenLabel.textColor = RedColor
            iconView.image = UIImage(named: "ic_assignment")
        }

        markAdDoneButton.hidden = !todo.editable
        if todo.editable {
            whenLabel.text = "press to mark as done"
            iconView.image = UIImage(named: "img_caller")
        }
    }

    @IBAction func markAsDone(sender: AnyObject) {
        PutMarkAsDone(id: todo!.id) { success in
            if success {
                self.doneHandler?()
            } else {
                self.shake()
                self.whenLabel.text = "error, try again"
            }
        }.start()
        
    }
}

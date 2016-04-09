//
//  TodosViewController.swift
//  Screaminder
//
//  Created by Anton Narusberg on 09/04/16.
//  Copyright © 2016 Screaminder. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var head: UIImageView!

    var todos: [Todo] = []

    override func loadView() {
        super.loadView()

        navigationController?.navigationBarHidden = false
        title = "Screaminders"

        tableView.dataSource = self

        GetReminders(completion: { todos in
            self.todos = todos
            self.tableView.reloadData()
        }).start()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    @IBAction func add(sender: AnyObject) {
        self.head.transform = CGAffineTransformMakeTranslation(-350, 0)
        self.head.hidden = false
        UIView.animateWithDuration(0.35, animations: {
            self.head.transform = CGAffineTransformIdentity
        }) { _ in
            UIView.animateWithDuration(0.35, delay: 0.5, options: .CurveEaseInOut, animations: {
                self.head.transform = CGAffineTransformMakeTranslation(350, 0)
                }, completion: { _ in
                    self.head.hidden = true
                    self.navigationController?.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("AddReminderViewController"), animated: true)
            })
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TODO", forIndexPath: indexPath) as! TodoTableViewCell
        cell.bind(todos[indexPath.row])
        return cell
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

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
    @IBOutlet weak var emptyPlaceholder: UILabel!

    var todos: [Todo] = []

    override func loadView() {
        super.loadView()

        navigationController?.navigationBarHidden = false
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo_small"))

        tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(TodosViewController.refresh),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        refresh()
    }

    func refresh() {
        GetReminders(completion: { todos in
            self.todos = todos
            self.emptyPlaceholder.hidden = todos.count > 0

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
        cell.doneHandler = {
            self.refresh()
        }
        return cell
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TODO", forIndexPath: indexPath) as! TodoTableViewCell
            cell.bind(todos[indexPath.row])
        return cell
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

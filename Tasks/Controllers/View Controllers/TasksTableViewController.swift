//
//  TasksTableViewController.swift
//  Tasks
//
//  Created by Aaron Cleveland on 1/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    // MARK: - Properties
    var tasks: [Task] {
        // THIS IS INEFFICIENT! DO NOT DO THIS IN PRODUCTION!
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        do {
            return try context.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching request: \(error)")
            return []
        }
    }
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        return cell
    }
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue" {
            if let detailVC = segue.destination as? TaskDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.task = tasks[indexPath.row]
            }
        }
    }

}

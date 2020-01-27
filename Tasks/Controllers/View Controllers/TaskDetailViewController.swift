//
//  ViewController.swift
//  Tasks
//
//  Created by Aaron Cleveland on 1/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Properties
    var task: Task?
    
    // MARK: - IBOutlet Setup
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if task == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let task = task {
            guard let name = nameTextField.text,
                !name.isEmpty else {
                    return
            }
            let notes = notesTextView.text
            task.name = name
            task.notes = notes
            do {
                try CoreDataStack.shared.mainContext.save()
            } catch {
                NSLog("Error saving managed object context: \(error)")
            }
        }
    }
    
    // MARK: - Helper Functions
    @objc func saveTask() {
        guard let name = nameTextField.text,
            !name.isEmpty else {
                return
        }
        let notes = notesTextView.text
        let _ = Task(name: name, notes: notes)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        notesTextView.text = task?.notes
    }
}


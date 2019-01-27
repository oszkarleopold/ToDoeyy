//
//  ViewController.swift
//  ToDoey
//
//  Created by Leopold Oszkár on 2019. 01. 27..
//  Copyright © 2019. Leopold Oszkár. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Bevásárlás", "Takarítás", "Mosogatás"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK - Tableview Datasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
    
    
    if selectedCell?.accessoryType == .checkmark {
        selectedCell?.accessoryType = .none
    }
    else {
        selectedCell?.accessoryType = .checkmark
    }
    tableView.deselectRow(at: indexPath, animated: true)
    
    }

}


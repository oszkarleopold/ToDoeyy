//
//  ViewController.swift
//  ToDoey
//
//  Created by Leopold Oszkár on 2019. 01. 27..
//  Copyright © 2019. Leopold Oszkár. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Bevásárlás", "Takarítás", "Mosogatás"]
    
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
    
    
    //MARK - ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Új elem hozzáadása", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Új lista", style: .default) { (action) in
            
            //What will happen once the user clicks the Add item on our UI alert
            print (textField.text!)
            
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
            alert.addTextField(configurationHandler: { (alertTextField) in
                    alertTextField.placeholder = "Új lista hozzáadása"
               textField = alertTextField
            
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }


    
    

}


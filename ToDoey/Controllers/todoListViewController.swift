//
//  ViewController.swift
//  ToDoey
//
//  Created by Leopold Oszkár on 2019. 01. 27..
//  Copyright © 2019. Leopold Oszkár. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Mosogatás"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Mosogatás"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Mosogatás"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        

        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    
        
        tableView.reloadData()

    tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    //MARK - ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Új elem hozzáadása", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Új lista", style: .default) { (action) in
            
            //What will happen once the user clicks the Add item on our UI alert
            print (textField.text!)
            
            let newItem = Item ()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
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


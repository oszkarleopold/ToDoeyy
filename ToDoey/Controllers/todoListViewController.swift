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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print (dataFilePath)

        
        loadItems ()
        
        
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
    
    saveItems()

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
            self.saveItems()
            

        }
            alert.addTextField(configurationHandler: { (alertTextField) in
                    alertTextField.placeholder = "Új lista hozzáadása"
               textField = alertTextField
            
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }


    func saveItems () {
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        } catch {
            print ("Error encoding item array, \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems () {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)}
            catch {
                print (error)
            }
        }
    }
}


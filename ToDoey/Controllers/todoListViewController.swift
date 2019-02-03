//
//  ViewController.swift
//  ToDoey
//
//  Created by Leopold Oszkár on 2019. 01. 27..
//  Copyright © 2019. Leopold Oszkár. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
             loadItems ()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print (dataFilePath!)

      searchBar.delegate = self
        
      
       
        
        
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
    
    
   // context.delete(itemArray[indexPath.row])
//    itemArray.remove(at: indexPath.row)
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
            
           
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
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
  
        
        do {
            
           try context.save()

        } catch {
            print ("Error saving context \(error)")
 
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems (with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])!
//        request.predicate = compoundPredicate
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print ("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    

}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
      //  let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        if searchBar.text?.count == 0
        if searchText == "" {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
    
    
}

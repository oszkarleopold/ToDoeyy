//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by Leopold Oszkár on 2019. 02. 03..
//  Copyright © 2019. Leopold Oszkár. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    
     //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        
        
        cell.textLabel?.text = category.name
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    

   
    
    
    
    //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Új kategória hozzáadása", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Új kategória", style: .default) { (action) in
            
            //What will happen once the user clicks the Add item on our UI alert
            print (textField.text!)
            
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
         
            
            
            self.categoryArray.append(newCategory)
            self.saveCategories()
            

        }
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "Új kategória hozzáadása"
            textField = alertTextField
            
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: - TableView delegate Methods
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    
    
    //MARK: - Data Manipluation Methods
    func saveCategories () {
        do {
            try context.save()
        } catch {
            print ("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print ("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
 
  
    
    
    
    
    
    
}

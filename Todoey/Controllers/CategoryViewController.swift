//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mihails Frolovs on 14/12/2018.
//  Copyright © 2018 Mihails Frolovs. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added"
        
//        let category = categoryArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
        
        
    }
    
    //MARK: - TableView Delegate Methods
    
    //MARK: - Data Manipulation Methods
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add" , style: .default) { (action) in
            
        let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new category"
                textField = alertTextField
             
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil )
        
            
    }
       
    func save(category: Category) {
            
            do {
                try realm.write {
                    realm.add(category)
                }

            } catch {
                print("Error saving context \(error)")
            }
            
            tableView.reloadData()
            
        }
    
    func loadCategories () {

        categoryArray = realm.objects(Category.self)
    
//        do {
//            categoryArray = try context.fetch(request)
//            print("success")
//        } catch {
//            print("error fetchingdata from context \(error)")
//        }

        tableView.reloadData()
    }

}

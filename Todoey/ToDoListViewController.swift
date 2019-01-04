//
//  ToDoViewController.swift
//  Todoey
//
//  Created by John on 1/4/19.
//  Copyright © 2019 Zendelle John Badiang. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["eat eggs","dont eat bacon", "drink water"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    //MARK - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    

    //MARK - TableView Delegate Method

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
         
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
       var textfield = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the item clicked the Add Item button on our UIAlert
            self.itemArray.append(textfield.text!)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
        }
        

        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}


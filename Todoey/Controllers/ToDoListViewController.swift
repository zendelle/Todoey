//
//  ToDoViewController.swift
//  Todoey
//
//  Created by John on 1/4/19.
//  Copyright © 2019 Zendelle John Badiang. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        let newItem = Item()
        newItem.Title = "Find Mike"
        itemArray.append(newItem)
        
        loadItems()
        

//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//        }
        
    }
    

    
    //MARK - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.Title
        
        //ternary operator
        //value = condition ? valueifTrue : ValueifFalse
        
        //value             |condition   |trueValue | falseValue
        cell.accessoryType = item.Done ? .checkmark : .none
        
        
        return cell
    }
    

    //MARK - TableView Delegate Method

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        
        //Makes the Done value equal its opposite
        itemArray[indexPath.row].Done = !itemArray[indexPath.row].Done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
       var textfield = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the item clicked the Add Item button on our UIAlert
            var newItem = Item()
            newItem.Title = textfield.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
        }
        

        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("An error has occured \(error)")
            }
        }
    }
    
}


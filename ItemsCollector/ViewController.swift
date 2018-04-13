//
//  ViewController.swift
//  ItemsCollector
//
//  Created by Mandeep Sarangal on 2018-04-07.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemsTableView: UITableView!
    
    var itemsArray : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
    }
    
    // to specify number of rows in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    // to specify what each cell will contain
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Setting image in each row
        // Also converting the Binary data into UIImage
        cell.imageView?.image = UIImage(data: item.image as! Data)
        return cell
    }
    
    // on table view item click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemsArray[indexPath.row]
        performSegue(withIdentifier: "itemSegue", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nectVC = segue.destination as! ItemViewController
        nectVC.sentItem = sender as? Item
    }
    
    // onResume
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // get all items in coreData
        do{
            itemsArray = try context.fetch(Item.fetchRequest())
            // refresh the table
            itemsTableView.reloadData()
        }
        catch{
            
        }
    }

}


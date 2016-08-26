//
//  ItemListViewController.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/15/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    //@IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate, ItemManagerSettable>!
    
    let itemManager = ItemManager()
    override func viewDidLoad() {
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
        dataProvider.itemManager = itemManager
    }
    @IBAction func addItem(sender: UIBarButtonItem) {
        
        if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("InputViewController")
            as? InputViewController {
            presentViewController(nextViewController, animated: true, completion: nil)
            nextViewController.itemManager = self.itemManager
        }
    }

}

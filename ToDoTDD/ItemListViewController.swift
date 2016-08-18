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
    
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate>!
    
    override func viewDidLoad() {
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
    }
}

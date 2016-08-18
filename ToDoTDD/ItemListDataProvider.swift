//
//  ItemListDataProvider.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/15/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

enum Section: Int {
    case ToDo
    case Done
}

class ItemListDataProvider: NSObject {
    var itemManage: ItemManager?
    
}

extension ItemListDataProvider: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManage else {
            return 0
        }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        
        let numberOfRows: Int
        
        switch itemSection {
            case .ToDo:
                numberOfRows = itemManager.toDoCount
            case .Done:
                numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        if let toDoItem = itemManage?.itemAtIndex(indexPath.row) {
            cell.configCellWithItem(toDoItem)
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    

}

extension ItemListDataProvider: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        let title: String?
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch section {
        case .ToDo:
            title = "Check"
        case .Done:
            title = "Uncheck"
        }
        
        return title
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let itemManage = itemManage else {
            fatalError()
        }
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch section {
        case .Done:
            itemManage.uncheckItemAtindex(indexPath.row)
        case .ToDo:
            itemManage.checkItemAtIndex(indexPath.row)

        tableView.reloadData()
        }
    }
    
}
















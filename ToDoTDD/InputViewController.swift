//
//  InputViewController.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/18/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    let dateFormater: NSDateFormatter = {
       
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "MM,dd/yyy"
        return dateFormater
    }()
    
    @IBAction func save() {
        guard let titleString = titleTextField.text
            where titleString.characters.count > 0 else {
                return
        }
        
        let date: NSDate?
        if let dateText = self.dateTextField.text where dateText.characters.count > 0 {
            date = dateFormater.dateFromString(dateText)
        } else {
            date = nil
        }
        
        let descriptionString: String?
        if descriptionTextField.text?.characters.count > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        
        if let locationName = locationTextField.text
            where locationName.characters.count > 0 {
                if let address = addressTextField.text
                    where address.characters.count > 0 {
                    geocoder.geocodeAddressString(address) {
                        [unowned self] (placeMarks, error) -> Void in
                        
                        let placeMark = placeMarks?.first
                        let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
                        self.itemManager?.addItem(item)
                    }
                } else {
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timestamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName))
                    
                    self.itemManager?.addItem(item)
                }
        } else {
            let item = ToDoItem(title: titleString,
                                itemDescription: descriptionString,
                                timestamp: date?.timeIntervalSince1970,
                                location: nil)
            
            self.itemManager?.addItem(item)
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
















//
//  KeychainAccessible.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/22/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
protocol KeychainAccessible {
    func setPassword(password: String, account: String)
    
    func deletePasswordForAccount(account: String)
    
    func passwordForAccount(accont: String) -> String?
    
}
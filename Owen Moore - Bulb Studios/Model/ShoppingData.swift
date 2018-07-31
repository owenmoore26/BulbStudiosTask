//
//  ShoppingData.swift
//  Owen Moore - Bulb Studios
//
//  Created by Ashley Moore on 31/07/2018.
//  Copyright © 2018 Owen Moore. All rights reserved.
//

import Foundation
import UIKit

// Structure of shopping items which conform to codable so I can use the Disk framework to save to the device memory.
struct ShoppingItems:Codable {
    
    // Declares a variable of type string.
    var item: String

    // Initialises the variable so it can be assigned to local constants or variables.
    init(item: String) {
        self.item = item
    }
}

// Where the item added to with the other items before their saved to memory.
var items = [ShoppingItems]()

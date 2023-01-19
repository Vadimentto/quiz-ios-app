//
//  Category.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 24.11.2022.
//

import Foundation
import UIKit

class Category {
    
    var name: String
    var selected = false
    
    init(name: String) {
        self.name = name
    }
}

struct CustomData {
    
    var image: UIImage
}


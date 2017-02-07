//
//  ChecklistsItem.swift
//  Checklists
//
//  Created by FengHaomin on 10/01/2017.
//  Copyright © 2017 HaoMin Feng. All rights reserved.
//

import Foundation

class ChecklistsItem {
    var text = ""
    var isChecked = false
    
    func toggleChecked() {
        isChecked = !isChecked
    }
}

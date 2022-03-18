//
//  Task.swift
//  TaskMaster
//
//  Created by LibUser on 3/10/22.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct Task: Codable, Hashable {
//MARK: Properties
    // Input Properties
    var label: String
    var date: Date
    
    //Other Properties
    var uuid: UUID = UUID()
    
    
//MARK: Create JSON
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case date = "date"
        case uuid = "uuid"
    }
}

 



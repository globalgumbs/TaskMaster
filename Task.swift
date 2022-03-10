//
//  Task.swift
//  TaskMaster
//
//  Created by LibUser on 3/10/22.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    //Properties
    let label: String
    let id = UUID()
    let date = Date()
    
}

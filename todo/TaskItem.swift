//
//  TaskItem.swift
//  todo
//
//  Created by sespure on 09.06.2026.
//

import Foundation
import SwiftData

@Model
final class TaskItem {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var dueDate: Date?

    init(title: String, isCompleted: Bool = false, createdAt: Date = Date(), dueDate: Date? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.dueDate = dueDate
    }
}

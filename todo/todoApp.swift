//
//  todoApp.swift
//  todo
//
//  Created by sespure on 08.06.2026.
//

import SwiftUI
import SwiftData

@main
struct todoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
}

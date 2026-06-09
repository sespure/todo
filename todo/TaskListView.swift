//
//  VListView.swift
//  todo
//
//  Created by sespure on 08.06.2026.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskItem]
    @State private var showingAddTask = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(tasks) { task in
                Text(task.title)
            }
                
                Button {
                    showingAddTask = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 56, height: 56)
                }
                .buttonStyle(.glassProminent)
                .clipShape(Circle())
                .padding(.trailing, 24)
                .padding(.bottom, 24)
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
        }
    }
}

#Preview {
    TaskListView()
}

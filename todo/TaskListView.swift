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
    @AppStorage("hideCompletedTasks") private var hideCompletedTasks = false
    @AppStorage("sortTasksByDueDate") private var sortTasksByDueDate = true
    @AppStorage("showDueDates") private var showDueDates = true

    private var displayedTasks: [TaskItem] {
        let filtered = hideCompletedTasks ? tasks.filter { !$0.isCompleted } : tasks

        guard sortTasksByDueDate else {
            return filtered.sorted { $0.createdAt < $1.createdAt }
        }

        return filtered.sorted { a, b in
            switch (a.dueDate, b.dueDate) {
            case let (lhs?, rhs?):
                return lhs < rhs
            case (nil, .some):
                return false
            case (.some, nil):
                return true
            default:
                return a.createdAt < b.createdAt
            }
        }
    }

    private func deleteTasks(at offsets: IndexSet, from items: [TaskItem]) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if displayedTasks.isEmpty {
                VStack(spacing: 12) {
                    Spacer()

                    Image(systemName: "checklist")
                        .font(.system(size: 38))
                        .foregroundStyle(.secondary)

                    Text(hideCompletedTasks ? "No visible tasks" : "No tasks yet")
                        .font(.headline)

                    Text(hideCompletedTasks ? "Turn off the filter in Settings to see completed tasks." : "Tap the plus button to add your first task.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 28)
            } else {
                List {
                    ForEach(displayedTasks) { task in
                        TaskRow(task: task, showDueDates: showDueDates)
                    }
                    .onDelete { offsets in
                        deleteTasks(at: offsets, from: displayedTasks)
                    }
                }
                .listStyle(.insetGrouped)
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

    struct TaskRow: View {
        @Bindable var task: TaskItem
        let showDueDates: Bool

        var body: some View {
            HStack(spacing: 12) {
                Toggle("", isOn: $task.isCompleted)
                    .labelsHidden()

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .strikethrough(task.isCompleted, color: .secondary)
                        .foregroundStyle(task.isCompleted ? .secondary : .primary)

                    if showDueDates, let dueDate = task.dueDate {
                        Text(dueDate, format: .dateTime.month().day().hour().minute())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                }
            }
        }
    }
}

#Preview {
    TaskListView()
}

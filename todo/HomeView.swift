//
//  HomeView.swift
//  todo
//
//  Created by sespure on 09.06.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var tasks: [TaskItem]
    @State private var showingAddTask = false
    @AppStorage("compactHomeHeader") private var compactHomeHeader = false
    @AppStorage("showDueDates") private var showDueDates = true
    @AppStorage("homeUpcomingLimit") private var homeUpcomingLimit = 5
    @AppStorage("highlightOverdueOnHome") private var highlightOverdueOnHome = true

    private var totalTasks: Int { tasks.count }
    private var doneTasks: Int { tasks.filter { $0.isCompleted }.count }
    private var leftTasks: Int { max(totalTasks - doneTasks, 0) }
    private var completionProgress: Double {
        guard totalTasks > 0 else { return 0 }
        return Double(doneTasks) / Double(totalTasks)
    }

    private var upcomingTasks: [TaskItem] {
        tasks
            .filter { !$0.isCompleted }
            .sorted { a, b in
                switch (a.dueDate, b.dueDate) {
                case let (lhs?, rhs?):
                    return lhs < rhs
                case (.some, nil):
                    return true
                case (nil, .some):
                    return false
                default:
                    return a.createdAt < b.createdAt
                }
            }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if compactHomeHeader {
                    HStack(spacing: 8) {
                        Text("Today")
                            .font(.title2.bold())
                        Text(Date.now, format: .dateTime.weekday(.abbreviated).month(.abbreviated).day())
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Today")
                            .font(.system(size: 40, weight: .bold))
                        Text(Date.now, format: .dateTime.weekday(.wide).month(.wide).day())
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    Text("Summary")
                        .font(.headline)

                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule(style: .continuous)
                                .fill(Color(.systemGray6))

                            Capsule(style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: max(geometry.size.width * completionProgress, 10))
                        }
                    }
                    .frame(height: 14)
                    .padding(.vertical, 4)

                    HStack {
                        statBlock(value: totalTasks, title: "Tasks")
                        Spacer()
                        statBlock(value: doneTasks, title: "Done")
                        Spacer()
                        statBlock(value: leftTasks, title: "Left")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .glassEffect(.regular, in: .rect(cornerRadius: 20))

                Button {
                    showingAddTask = true
                } label: {
                    Label("Add Task", systemImage: "plus")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)

                VStack(alignment: .leading, spacing: 14) {
                    Text("Next Tasks")
                        .font(.headline)

                    if upcomingTasks.isEmpty {
                        Text("No upcoming tasks")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(upcomingTasks.prefix(max(homeUpcomingLimit, 1))) { task in
                            HStack(spacing: 10) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 7))
                                    .foregroundStyle(.secondary)

                                Text(task.title)
                                    .lineLimit(1)

                                Spacer()

                                if showDueDates, let dueDate = task.dueDate {
                                    Text(dueDate, format: .dateTime.month().day().hour().minute())
                                        .font(.caption)
                                        .foregroundStyle(highlightOverdueOnHome && dueDate < .now ? .red : .secondary)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .glassEffect(.regular, in: .rect(cornerRadius: 20))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, compactHomeHeader ? 8 : 20)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
        }
    }

    private func statBlock(value: Int, title: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(value)")
                .font(.title3.weight(.semibold))
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HomeView()
}


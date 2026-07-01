//
//  SettingsView.swift
//  todo
//
//  Created by sespure on 09.06.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideCompletedTasks") private var hideCompletedTasks = false
    @AppStorage("sortTasksByDueDate") private var sortTasksByDueDate = true
    @AppStorage("showDueDates") private var showDueDates = true
    @AppStorage("compactHomeHeader") private var compactHomeHeader = false
    @AppStorage("homeUpcomingLimit") private var homeUpcomingLimit = 5
    @AppStorage("highlightOverdueOnHome") private var highlightOverdueOnHome = true
    @State private var showingUpcomingTasksPicker = false

    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }

    private var appBuild: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Tasks") {
                    Toggle("Hide completed tasks", isOn: $hideCompletedTasks)
                    Toggle("Sort by due date", isOn: $sortTasksByDueDate)
                    Toggle("Show due dates", isOn: $showDueDates)
                }

                Section("Home") {
                    Toggle("Compact home header", isOn: $compactHomeHeader)
                    Toggle("Highlight overdue tasks", isOn: $highlightOverdueOnHome)

                    Button {
                        withAnimation(.snappy) {
                            showingUpcomingTasksPicker.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Upcoming tasks shown")
                            Spacer()
                            Text("\(homeUpcomingLimit)")
                                .foregroundStyle(.secondary)
                            Image(systemName: showingUpcomingTasksPicker ? "chevron.up" : "chevron.down")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)

                    if showingUpcomingTasksPicker {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Choose how many tasks appear on Home")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Picker("Upcoming tasks shown", selection: $homeUpcomingLimit) {
                                ForEach(3...12, id: \.self) { value in
                                    Text("\(value)").tag(value)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 140)
                        }
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }

                Section {
                    NavigationLink {
                        AppInfoDetailsView(appVersion: appVersion, appBuild: appBuild)
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.accentColor.opacity(0.15))
                                    .frame(width: 52, height: 52)
                                Image(systemName: "checklist.checked")
                                    .font(.title2)
                                    .foregroundStyle(Color.accentColor)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Todo")
                                    .font(.headline)
                                Text("Stay focused, finish more")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

private struct AppInfoDetailsView: View {
    let appVersion: String
    let appBuild: String

    var body: some View {
        Form {
            Section("About") {
                LabeledContent("Version", value: appVersion)
                LabeledContent("Build", value: appBuild)
                LabeledContent("Developer", value: "sespure")
            }

            Section("Support") {
                Link("Contact Support", destination: URL(string: "mailto:andrii.chernychka@student.uzhnu.edu.ua")!)
                Link("Report a Bug", destination: URL(string: "mailto:andrii.chernychka@student.uzhnu.edu.ua")!)
            }

            Section("Legal") {
                Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                Link("Terms of Use", destination: URL(string: "https://example.com/terms")!)
            }
        }
        .navigationTitle("About Todo")
    }
}

#Preview {
    SettingsView()
}

# Todo

Todo is a SwiftUI task management app that uses SwiftData for local persistence.

## Screenshots

![Home Screen](docs/screenshots/home-screen.png)

![Task List](docs/screenshots/task-list.png)

![Add Task Sheet](docs/screenshots/add-task-sheet.png)

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

SwiftData requires iOS 17 and Swift 5.9 or newer.

## Overview

The app is organized around a simple tab-based structure:

- Home: Provides a dashboard-style entry point for the user's day.
- Tasks: Displays persisted tasks and provides access to task creation.
- Settings: Reserved for future app preferences and configuration.

SwiftData is configured at the app root so task data can be shared across screens through the SwiftUI environment.

## Project Structure

- `todo/todoApp.swift`: App entry point and SwiftData container setup.
- `todo/ContentView.swift`: Main tab navigation.
- `todo/HomeView.swift`: Home dashboard screen.
- `todo/TaskListView.swift`: Task list screen.
- `AddTaskView.swift`: Task creation sheet.
- `todo/TaskItem.swift`: Persistent task model.
- `todo/SettingsView.swift`: Settings screen.
- `todo/Assets.xcassets`: App assets.
- `todo.xcodeproj`: Xcode project configuration.

## Architecture

The current architecture is intentionally small:

- SwiftUI owns presentation and navigation.
- SwiftData owns local persistence.
- The task list observes persisted task data and updates automatically when changes are saved.
- Task creation is isolated in a separate sheet so the list remains focused on displaying saved tasks.

This keeps the project easy to extend while the app is still early in development.

## Data Flow

Task data flows through the app like this:

1. The app configures SwiftData when it launches.
2. The Tasks screen reads saved task data from SwiftData.
3. The user opens the add-task sheet from the Tasks screen.
4. The add-task sheet collects form input from the user.
5. Saving creates a new task in SwiftData.
6. The Tasks screen refreshes from its SwiftData query and displays the new task.

This flow keeps task persistence centralized in SwiftData while letting SwiftUI react to model changes.

## Current Limitations

- Home summary values are placeholder content.
- Settings is a placeholder screen.
- Tasks can be created, but editing, deletion, completion toggling, and due dates are not implemented yet.
- Screenshot assets still need to be added under `docs/screenshots/`.

## Build And Run

Open the project in Xcode and run the `todo` app target on an iOS 17.0+ simulator or device.

## Documentation Rule

Keep this README focused on high-level project information:

- App purpose and requirements.
- Major screens and modules.
- Architecture and data flow.
- Setup or dependency changes.
- Architectural Decision Records when important technical decisions are made.

Do not document implementation details, obvious property names, basic SwiftUI syntax, or small local state here. Use DocC comments near the relevant code only when a function, algorithm, or local state is complex enough to need explanation.

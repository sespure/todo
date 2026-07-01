# Todo

Todo is a SwiftUI task management app that uses SwiftData for local persistence.

Current app version: 1.1

## Screenshots

<div align="center">
  
| Home Screen | Task List | Add Task Sheet |
|:-:|:-:|:-:|
| <img src="https://github.com/user-attachments/assets/fecd4ade-d5a9-4e5e-82de-73194a864db9" width="190" alt="Home Screen"/> | <img src="https://github.com/user-attachments/assets/3b3cb204-6206-4a83-b7e4-0b898dc29503" width="190" alt="Task List"/> | <img src="https://github.com/user-attachments/assets/432dbe7e-7905-44c9-8b81-234581707951" width="190" alt="Add Task Sheet"/> |

</div>

## Requirements

- iOS 26.0+
- Xcode 26.5+
- Swift language mode: Swift 5
- Supported devices: iPhone and iPad

The app uses SwiftData and optionally the SwiftUI Liquid Glass UI modifiers. SwiftData requires a modern SDK; the project currently targets iOS 26 in its Xcode settings. If you don't have Liquid Glass modifiers available in your SDK, either update Xcode or remove/replace the custom glass modifiers in the UI.

## Overview

The app is organized around a simple tab-based structure:

- Home: A dashboard-style entry point with summary stats, an add-task action, and a next-tasks preview.
- Tasks: Displays persisted tasks, supports completion toggling, filtering, sorting, and deletion, and provides access to task creation.
- Settings: Controls task visibility, home-screen presentation, and app information.

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

- Screenshot assets still need to be added under `docs/screenshots/`.
- Editing tasks in-place is not implemented yet.
- The app is still intentionally lightweight and focused on local task management.

## Build And Run

Open the project in Xcode and run the `todo` app target on an iOS 26.0+ simulator or device.

Project versioning:

- Marketing Version: 1.1
- Current Project Version (build): 2

## Documentation Rule

Keep this README focused on high-level project information:

- App purpose and requirements.
- Major screens and modules.
- Architecture and data flow.
- Setup or dependency changes.
- Architectural Decision Records when important technical decisions are made.

Do not document implementation details, obvious property names, basic SwiftUI syntax, or small local state here. Use DocC comments near the relevant code only when a function, algorithm, or local context is complex or non-obvious.

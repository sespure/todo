# Todo

Todo is a SwiftUI app for creating and viewing simple tasks. It uses SwiftData to store tasks locally on the device.

## Current Features

- Tab-based app layout with Home, Tasks, and Settings screens.
- SwiftData-backed task model.
- Task list that reads saved tasks from the model context.
- Add task sheet where the user can type a task name and save it.
- Basic home dashboard and settings screen placeholders.

## Project Structure

- `todo/todoApp.swift`: App entry point. Creates the main window and configures the SwiftData model container for `TaskItem`.
- `todo/ContentView.swift`: Main tab navigation for Home, Tasks, and Settings.
- `todo/HomeView.swift`: Home dashboard screen.
- `todo/TaskListView.swift`: Shows saved tasks and presents the add-task sheet.
- `AddTaskView.swift`: Form screen for creating a new task.
- `todo/TaskItem.swift`: SwiftData model for a task.
- `todo/SettingsView.swift`: Settings screen.
- `todo/Assets.xcassets`: App assets.

## Data Model

`TaskItem` is the main model object.

It stores:

- `title`: The task name.
- `isCompleted`: Whether the task is done.
- `createdAt`: When the task was created.

The app registers this model in `todoApp.swift`:

```swift
.modelContainer(for: TaskItem.self)
```

That makes SwiftData available to views through `modelContext` and `@Query`.

## Task Creation Flow

The Tasks tab shows `TaskListView`.

When the plus button is tapped:

1. `showingAddTask` becomes `true`.
2. SwiftUI presents `AddTaskView` as a sheet.
3. The user types a task name.
4. The Save button creates a `TaskItem`.
5. The new task is inserted into SwiftData with `modelContext.insert(newTask)`.
6. The sheet closes and the task appears in the list.

## Build And Run

Open the project in Xcode and run the `todo` app target.

The current project was validated with:

- Xcode live diagnostics for the edited Swift files.
- Full Xcode project build.

## History

- `53225a9 Initial Commit`: Created the initial Xcode project.
- `60c7380 Add SwiftData task creation flow`: Added the SwiftData task model, tab layout, task list, add-task sheet, home screen, settings screen, and persistence setup.

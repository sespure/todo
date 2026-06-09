# Todo

Todo is a SwiftUI app for creating and viewing simple tasks. It uses SwiftData for local persistence, so saved tasks are stored by the app instead of existing only in memory.

## Current Status

The project currently has a working task creation path:

- The app opens into a tab layout.
- The Tasks tab shows saved tasks.
- The plus button opens an add-task sheet.
- The user types a task name and taps Save.
- A `TaskItem` is inserted into SwiftData.
- The list updates from the SwiftData query.

The Home and Settings screens exist, but they are still early placeholder screens. Home shows static summary numbers and static next-task rows. Settings currently shows starter text.

## Features

- SwiftUI app lifecycle.
- Tab-based navigation with Home, Tasks, and Settings.
- SwiftData model container configured at the app root.
- Persistent `TaskItem` model.
- Task list backed by `@Query`.
- Add-task form presented as a sheet.
- Save and Cancel actions in the add-task form.
- Basic README documentation and Git history.

## Project Structure

- `todo/todoApp.swift`: App entry point. Creates the main window and registers the SwiftData model container.
- `todo/ContentView.swift`: Main tab interface.
- `todo/HomeView.swift`: Home dashboard screen.
- `todo/TaskListView.swift`: Task list screen and add button.
- `AddTaskView.swift`: Sheet form used to create a task.
- `todo/TaskItem.swift`: SwiftData model for a task.
- `todo/SettingsView.swift`: Settings screen placeholder.
- `todo/Assets.xcassets`: App colors and icons.
- `todo.xcodeproj`: Xcode project configuration.

## App Entry Point

File: `todo/todoApp.swift`

Main type:

```swift
@main
struct todoApp: App
```

Responsibilities:

- Starts the SwiftUI app.
- Shows `ContentView` inside the main `WindowGroup`.
- Registers `TaskItem` with SwiftData:

```swift
.modelContainer(for: TaskItem.self)
```

This setup is required before views can use:

- `@Environment(\.modelContext)`
- `@Query`

## Main Navigation

File: `todo/ContentView.swift`

Main type:

```swift
struct ContentView: View
```

Responsibilities:

- Creates the main `TabView`.
- Adds three tabs:
  - Home: `HomeView()`
  - Tasks: `TaskListView()`
  - Settings: `SettingsView()`

Important UI:

```swift
Tab("Home", systemImage: "house.fill") {
    HomeView()
}
```

```swift
Tab("Tasks", systemImage: "list.bullet.clipboard.fill") {
    TaskListView()
}
```

```swift
Tab("Settings", systemImage: "gearshape.fill") {
    SettingsView()
}
```

## Task Model

File: `todo/TaskItem.swift`

Main type:

```swift
@Model
final class TaskItem
```

`TaskItem` is the main persistent data type for the app.

Properties:

- `title: String`: The visible task name.
- `isCompleted: Bool`: Whether the task is complete. Defaults to `false`.
- `createdAt: Date`: The creation date. Defaults to the current date.

Initializer:

```swift
init(title: String, isCompleted: Bool = false, createdAt: Date = Date())
```

The initializer lets the app create a task with only a title:

```swift
TaskItem(title: "Buy milk")
```

Swift fills in:

- `isCompleted = false`
- `createdAt = Date()`

## Task List Screen

File: `todo/TaskListView.swift`

Main type:

```swift
struct TaskListView: View
```

Responsibilities:

- Reads tasks from SwiftData.
- Displays task titles in a `List`.
- Shows a floating plus button.
- Presents `AddTaskView` when the plus button is tapped.

Important properties:

```swift
@Environment(\.modelContext) private var modelContext
```

Gives the view access to SwiftData's model context. This view currently declares it but does not directly insert or delete tasks.

```swift
@Query private var tasks: [TaskItem]
```

Fetches all saved `TaskItem` objects from SwiftData and keeps the UI updated when the data changes.

```swift
@State private var showingAddTask = false
```

Controls whether the add-task sheet is visible.

Main list:

```swift
List(tasks) { task in
    Text(task.title)
}
```

Plus button action:

```swift
Button {
    showingAddTask = true
} label: {
    Image(systemName: "plus")
}
```

This does not create a task directly. It only opens the add-task sheet.

Sheet presentation:

```swift
.sheet(isPresented: $showingAddTask) {
    AddTaskView()
}
```

When `showingAddTask` becomes `true`, SwiftUI presents `AddTaskView`.

## Add Task Screen

File: `AddTaskView.swift`

Main type:

```swift
struct AddTaskView: View
```

Responsibilities:

- Shows a form where the user can type a task name.
- Lets the user cancel without saving.
- Lets the user save a new task.
- Inserts the new task into SwiftData.
- Closes after Cancel or Save.

Important properties:

```swift
@Environment(\.dismiss) private var dismiss
```

Allows the view to close itself.

```swift
@Environment(\.modelContext) private var modelContext
```

Gives access to SwiftData so the view can insert a new task.

```swift
@State private var title = ""
```

Stores the text typed into the task name field.

Text field:

```swift
TextField("Task name", text: $title)
```

This binds the text field to the `title` state.

Cancel action:

```swift
Button("Cancel") {
    dismiss()
}
```

Closes the sheet without creating a task.

Save action:

```swift
Button("Save") {
    let newTask = TaskItem(title: title)
    modelContext.insert(newTask)
    dismiss()
}
```

Creates a `TaskItem`, inserts it into SwiftData, then closes the sheet.

Save button validation:

```swift
.disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
```

Prevents saving an empty task name or a name that only contains spaces.

## Home Screen

File: `todo/HomeView.swift`

Main type:

```swift
struct HomeView: View
```

Current responsibilities:

- Shows a `Today` heading.
- Shows a summary card with static numbers:
  - 8 Tasks
  - 3 Done
  - 5 Left
- Shows an Add Task button placeholder.
- Shows static next-task rows:
  - Task 1 at 10:00
  - Task 2 at 12:00

Important properties:

```swift
@Environment(\.modelContext) private var modelContext
@Query private var tasks: [TaskItem]
```

These are already available in the view, but the current Home UI does not yet use `tasks` to calculate the summary.

Known future work:

- Replace static summary numbers with real counts from `tasks`.
- Connect the Home Add Task button to the same add-task flow.
- Replace static next-task rows with real task data.

## Settings Screen

File: `todo/SettingsView.swift`

Main type:

```swift
struct SettingsView: View
```

Current responsibility:

- Shows starter placeholder text.

Known future work:

- Add real app settings when the app needs them.

## Data Flow

The current task creation flow is:

1. `ContentView` shows the Tasks tab.
2. The Tasks tab loads `TaskListView`.
3. `TaskListView` reads saved tasks using `@Query`.
4. The user taps the plus button.
5. `TaskListView` sets `showingAddTask = true`.
6. SwiftUI presents `AddTaskView` as a sheet.
7. The user types a task name.
8. The user taps Save.
9. `AddTaskView` creates `TaskItem(title: title)`.
10. `AddTaskView` inserts the task with `modelContext.insert(newTask)`.
11. `AddTaskView` calls `dismiss()`.
12. SwiftData updates the query.
13. `TaskListView` refreshes and shows the new task title.

## Important SwiftUI And SwiftData Concepts Used

- `View`: A SwiftUI screen or reusable UI piece.
- `body`: The computed property that describes a view's UI.
- `@State`: Local view state owned by the view.
- `@Environment`: Values provided by SwiftUI or the app environment.
- `@Query`: SwiftData property wrapper for fetching model objects.
- `@Model`: SwiftData macro that makes a class persistent.
- `modelContext.insert(...)`: Adds a new model object to SwiftData.
- `.sheet(...)`: Presents another view modally.
- `NavigationStack`: Provides navigation and toolbar structure for the add-task form.
- `ToolbarItem`: Places Cancel and Save actions in the form toolbar.

## Build And Run

Open the project in Xcode and run the `todo` app target.

The project has been validated with:

- Xcode live diagnostics for edited Swift files.
- Full Xcode project build.

## GitHub

Repository:

```text
https://github.com/sespure/todo
```

The local `main` branch is configured to track `origin/main`.

Useful commands:

```bash
git status
git pull
git push
git log --oneline
```

## Project History

- `53225a9 Initial Commit`: Created the initial local Xcode project.
- `60c7380 Add SwiftData task creation flow`: Added the SwiftData task model, tab layout, task list, add-task sheet, home screen, settings screen, and persistence setup.
- `1f2cf4b Document todo app structure`: Added the first README with the project structure, task model, task creation flow, build notes, and history.

## Documentation Rule For This Project

Keep this README updated whenever the project changes.

When adding or changing code, document:

- New files.
- New views.
- New models.
- New functions or actions.
- Important state properties.
- Data flow changes.
- Build or setup changes.
- Git history entries for important commits.

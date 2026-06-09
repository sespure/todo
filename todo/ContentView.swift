//
//  ContentView.swift
//  todo
//
//  Created by sespure on 08.06.2026.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }


            Tab("Tasks", systemImage: "list.bullet.clipboard.fill") {
                TaskListView()
            }


            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }

            }
        }


#Preview {
    ContentView()
}

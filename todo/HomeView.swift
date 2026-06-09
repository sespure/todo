//
//  HomeView.swift
//  todo
//
//  Created by sespure on 09.06.2026.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskItem]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Today")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            
            VStack(alignment: .leading, spacing: 16) {
                Text("Summary")
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("8")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Tasks")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("3")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Done")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("5")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Left")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                    }
                }
            }
            .padding(20)
            .glassEffect(.regular, in: .rect(cornerRadius: 20))
            
            Button {
                // main logic for button will be here
            } label: {
                Label("Add Task", systemImage: "plus")
            }
            .buttonStyle(.glass)
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Next Tasks")
                    .font(.headline)
                
                HStack {
                    Text("Task 1")
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    Text("10:00")
                        .font(.caption)
                }
                
                HStack {
                    Text("Task 2")
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    Text("12:00")
                        .font(.caption)
                }
            }
            .padding(20)
            .glassEffect(.regular, in: .rect(cornerRadius: 20))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}


#Preview {
    HomeView()
}

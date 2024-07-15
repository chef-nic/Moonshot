//
//  ContentView.swift
//  Moonshot
//
//  Created by Nicholas Johnson on 7/13/24.
//

import SwiftUI

struct ContentView: View {
    // Type annotation so Swift knows the Type (because decode uses a generic: <T>)
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @AppStorage("showingGrid") private var showGrid: Bool = true
    private var toolbarButton: String {
        showGrid ? "List" : "Grid"
    }
    
    
    var body: some View {
        NavigationStack {
            Group {
                if showGrid {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .toolbar {
                Button(toolbarButton) {
                    showGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}



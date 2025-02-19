//
//  ContentView.swift
//  Kana-neuralSensei
//
//  Created by quentin on 2/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            QuizView()
                .tabItem {
                    Label("Quiz", systemImage: "brain.head.profile")
                }
            
            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "book.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Study Settings") {
                    Toggle("Include Hiragana", isOn: .constant(true))
                    Toggle("Include Katakana", isOn: .constant(true))
                }
                
                Section("App Settings") {
                    // Placeholder for app settings
                }
            }
            .navigationTitle("Settings")
        }
    }
} 
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Learn Japanese")
                    .font(.largeTitle)
                    .bold()
                
                Text("Start your journey with Hiragana and Katakana")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .navigationTitle("Home")
        }
    }
} 
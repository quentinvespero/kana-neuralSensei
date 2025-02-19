import SwiftUI

struct TrainingView: View {
    @State private var trainingVM = TrainingViewModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Configuration Section
                    VStack(alignment: .leading, spacing: 16) {
                        // Translation Direction
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Translation Direction:")
                                .font(.headline)
                            Picker("Direction", selection: $trainingVM.translationDirection) {
                                ForEach(TranslationDirection.allCases, id: \.self) { direction in
                                    Text(direction.rawValue).tag(direction)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .onChange(of: trainingVM.translationDirection) { oldValue, newValue in
                            Task {
                                await trainingVM.generateNewPhrase()
                            }
                        }
                        
                        // Japanese Format
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Japanese Format:")
                                .font(.headline)
                            Picker("Format", selection: $trainingVM.japaneseFormat) {
                                ForEach(JapaneseFormat.allCases, id: \.self) { format in
                                    Text(format.rawValue).tag(format)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .onChange(of: trainingVM.japaneseFormat) { oldValue, newValue in
                            Task {
                                await trainingVM.generateNewPhrase()
                            }
                        }
                        
                        // Difficulty
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Difficulty:")
                                .font(.headline)
                            Picker("Difficulty", selection: $trainingVM.difficulty) {
                                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                    Text(difficulty.rawValue).tag(difficulty)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .onChange(of: trainingVM.difficulty) { oldValue, newValue in
                            Task {
                                await trainingVM.generateNewPhrase()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Generated Phrase Section
                    if !trainingVM.originalPhrase.isEmpty {
                        VStack(spacing: 16) {
                            Text("Translate this:")
                                .font(.headline)
                            
                            Text(trainingVM.originalPhrase)
                                .font(.system(size: 24, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.blue.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal)
                        
                        // Translation Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your translation:")
                                .font(.headline)
                            
                            TextField("Enter your translation", text: $trainingVM.userTranslation)
                                .textFieldStyle(.roundedBorder)
                                .focused($isInputFocused)
                                .submitLabel(.done)
                            
                            Button("Check Translation") {
                                isInputFocused = false
                                Task {
                                    await trainingVM.checkTranslation()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(trainingVM.userTranslation.isEmpty)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Feedback Section
                    if !trainingVM.feedback.isEmpty {
                        Text(trainingVM.feedback)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.green.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                    
                    // Generate Button
                    Button {
                        Task {
                            await trainingVM.generateNewPhrase()
                            trainingVM.userTranslation = ""
                            trainingVM.clearFeedback()
                        }
                    } label: {
                        Text("Generate New Phrase")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Training")
            .overlay {
                if trainingVM.isLoading {
                    Color.black.opacity(0.1)
                        .ignoresSafeArea()
                        .overlay {
                            ProgressView()
                                .scaleEffect(1.5)
                        }
                }
            }
        }
    }
} 
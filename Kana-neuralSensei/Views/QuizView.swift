import SwiftUI

struct QuizView: View {
    @State private var quizVM = QuizViewModel()
    @State private var showScoreAnimation = false
    @State private var isCorrect = false
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Kana Type Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Characters to Study:")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        // Writing Systems
                        HStack {
                            Toggle("Hiragana", isOn: $quizVM.includeHiragana)
                            Divider()
                            Toggle("Katakana", isOn: $quizVM.includeKatakana)
                        }
                        
                        // Diacritics
                        HStack {
                            Toggle("Dakuten (゛)", isOn: $quizVM.includeDakuten)
                            Divider()
                            Toggle("Handakuten (゜)", isOn: $quizVM.includeHandakuten)
                        }
                    }
                    .onChange(of: quizVM.includeHiragana) { oldValue, newValue in
                        Task { @MainActor in
                            await quizVM.generateNewQuestion()
                        }
                    }
                    .onChange(of: quizVM.includeKatakana) { oldValue, newValue in
                        Task { @MainActor in
                            await quizVM.generateNewQuestion()
                        }
                    }
                    .onChange(of: quizVM.includeDakuten) { oldValue, newValue in
                        Task { @MainActor in
                            await quizVM.generateNewQuestion()
                        }
                    }
                    .onChange(of: quizVM.includeHandakuten) { oldValue, newValue in
                        Task { @MainActor in
                            await quizVM.generateNewQuestion()
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    // Quiz Mode Selection
                    Picker("Quiz Mode", selection: $quizVM.quizMode) {
                        Text("Kana to Romaji").tag(QuizMode.kanaToRomaji)
                        Text("Romaji to Kana").tag(QuizMode.romajiToKana)
                    }
                    .pickerStyle(.segmented)
                    
                    // Input Type Selection
                    Picker("Input Type", selection: $quizVM.inputType) {
                        Text("Multiple Choice").tag(QuizInputType.multipleChoice)
                        Text("Keyboard").tag(QuizInputType.keyboard)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                
                if let question = quizVM.currentQuestion {
                    Text(quizVM.quizMode == .kanaToRomaji ? question.kana : question.romaji)
                        .font(.system(size: 80))
                        .bold()
                    
                    if quizVM.inputType == .multipleChoice {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(quizVM.options, id: \.self) { option in
                                Button {
                                    isCorrect = quizVM.checkAnswer(option)
                                    if isCorrect {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                            showScoreAnimation = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            Task { @MainActor in
                                                await quizVM.generateNewQuestion()
                                                showScoreAnimation = false
                                            }
                                        }
                                    }
                                } label: {
                                    Text(option)
                                        .font(.title2)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    } else {
                        // Keyboard input
                        VStack(spacing: 16) {
                            TextField("Type your answer", text: $quizVM.userInput)
                                .textFieldStyle(.roundedBorder)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .focused($isInputFocused)
                                .submitLabel(.done)
                                .onSubmit {
                                    checkKeyboardInput()
                                }
                            
                            Button("Check") {
                                checkKeyboardInput()
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(quizVM.userInput.isEmpty)
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Score with animation
                HStack {
                    Text("Score:")
                        .font(.title2)
                    
                    Text("\(quizVM.score)")
                        .font(.title2.bold())
                        .scaleEffect(showScoreAnimation ? 1.5 : 1.0)
                        .foregroundColor(showScoreAnimation ? .green : .primary)
                }
                .frame(height: 44) // Fixed height to prevent layout shifts
                
                if quizVM.showFeedback {
                    Text(quizVM.feedbackMessage)
                        .foregroundColor(quizVM.isCorrectAnswer ? .green : .red)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.1))
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .navigationTitle("Quiz")
            .task { @MainActor in
                await quizVM.generateNewQuestion()
            }
        }
        .animation(.easeInOut, value: quizVM.showFeedback)
    }
    
    private func checkKeyboardInput() {
        isInputFocused = false
        isCorrect = quizVM.checkAnswer(quizVM.userInput)
        if isCorrect {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                showScoreAnimation = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                Task { @MainActor in
                    quizVM.userInput = ""
                    showScoreAnimation = false
                }
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
} 
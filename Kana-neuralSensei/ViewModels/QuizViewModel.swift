import SwiftUI

// Move the extension to file scope (outside the class)
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

@Observable
class QuizViewModel {
    // Basic Hiragana (あ行, か行, さ行, た行, な行)
    private var hiraganaCharacters: [KanaCharacter] = [
        // あ行 (a, i, u, e, o)
        KanaCharacter(kana: "あ", romaji: "a", type: .hiragana),
        KanaCharacter(kana: "い", romaji: "i", type: .hiragana),
        KanaCharacter(kana: "う", romaji: "u", type: .hiragana),
        KanaCharacter(kana: "え", romaji: "e", type: .hiragana),
        KanaCharacter(kana: "お", romaji: "o", type: .hiragana),
        
        // か行 (ka, ki, ku, ke, ko)
        KanaCharacter(kana: "か", romaji: "ka", type: .hiragana),
        KanaCharacter(kana: "き", romaji: "ki", type: .hiragana),
        KanaCharacter(kana: "く", romaji: "ku", type: .hiragana),
        KanaCharacter(kana: "け", romaji: "ke", type: .hiragana),
        KanaCharacter(kana: "こ", romaji: "ko", type: .hiragana),
        
        // さ行 (sa, shi, su, se, so)
        KanaCharacter(kana: "さ", romaji: "sa", type: .hiragana),
        KanaCharacter(kana: "し", romaji: "shi", type: .hiragana),
        KanaCharacter(kana: "す", romaji: "su", type: .hiragana),
        KanaCharacter(kana: "せ", romaji: "se", type: .hiragana),
        KanaCharacter(kana: "そ", romaji: "so", type: .hiragana),
        
        // た行 (ta, chi, tsu, te, to)
        KanaCharacter(kana: "た", romaji: "ta", type: .hiragana),
        KanaCharacter(kana: "ち", romaji: "chi", type: .hiragana),
        KanaCharacter(kana: "つ", romaji: "tsu", type: .hiragana),
        KanaCharacter(kana: "て", romaji: "te", type: .hiragana),
        KanaCharacter(kana: "と", romaji: "to", type: .hiragana),
        
        // な行 (na, ni, nu, ne, no)
        KanaCharacter(kana: "な", romaji: "na", type: .hiragana),
        KanaCharacter(kana: "に", romaji: "ni", type: .hiragana),
        KanaCharacter(kana: "ぬ", romaji: "nu", type: .hiragana),
        KanaCharacter(kana: "ね", romaji: "ne", type: .hiragana),
        KanaCharacter(kana: "の", romaji: "no", type: .hiragana),
        
        // は行 (ha, hi, fu, he, ho)
        KanaCharacter(kana: "は", romaji: "ha", type: .hiragana),
        KanaCharacter(kana: "ひ", romaji: "hi", type: .hiragana),
        KanaCharacter(kana: "ふ", romaji: "fu", type: .hiragana),
        KanaCharacter(kana: "へ", romaji: "he", type: .hiragana),
        KanaCharacter(kana: "ほ", romaji: "ho", type: .hiragana),
        
        // ま行 (ma, mi, mu, me, mo)
        KanaCharacter(kana: "ま", romaji: "ma", type: .hiragana),
        KanaCharacter(kana: "み", romaji: "mi", type: .hiragana),
        KanaCharacter(kana: "む", romaji: "mu", type: .hiragana),
        KanaCharacter(kana: "め", romaji: "me", type: .hiragana),
        KanaCharacter(kana: "も", romaji: "mo", type: .hiragana),
        
        // や行 (ya, yu, yo)
        KanaCharacter(kana: "や", romaji: "ya", type: .hiragana),
        KanaCharacter(kana: "ゆ", romaji: "yu", type: .hiragana),
        KanaCharacter(kana: "よ", romaji: "yo", type: .hiragana),
        
        // ら行 (ra, ri, ru, re, ro)
        KanaCharacter(kana: "ら", romaji: "ra", type: .hiragana),
        KanaCharacter(kana: "り", romaji: "ri", type: .hiragana),
        KanaCharacter(kana: "る", romaji: "ru", type: .hiragana),
        KanaCharacter(kana: "れ", romaji: "re", type: .hiragana),
        KanaCharacter(kana: "ろ", romaji: "ro", type: .hiragana),
        
        // わ行 (wa, wo)
        KanaCharacter(kana: "わ", romaji: "wa", type: .hiragana),
        KanaCharacter(kana: "を", romaji: "wo", type: .hiragana),
        
        // ん (n)
        KanaCharacter(kana: "ん", romaji: "n", type: .hiragana),
        
        // Dakuten variations
        // が行 (ga, gi, gu, ge, go)
        KanaCharacter(kana: "が", romaji: "ga", type: .hiragana),
        KanaCharacter(kana: "ぎ", romaji: "gi", type: .hiragana),
        KanaCharacter(kana: "ぐ", romaji: "gu", type: .hiragana),
        KanaCharacter(kana: "げ", romaji: "ge", type: .hiragana),
        KanaCharacter(kana: "ご", romaji: "go", type: .hiragana),
        
        // ざ行 (za, ji/zi, zu, ze, zo)
        KanaCharacter(kana: "ざ", romaji: "za", type: .hiragana),
        KanaCharacter(kana: "じ", romaji: "ji", type: .hiragana),
        KanaCharacter(kana: "ず", romaji: "zu", type: .hiragana),
        KanaCharacter(kana: "ぜ", romaji: "ze", type: .hiragana),
        KanaCharacter(kana: "ぞ", romaji: "zo", type: .hiragana),
        
        // だ行 (da, ji, zu, de, do)
        KanaCharacter(kana: "だ", romaji: "da", type: .hiragana),
        KanaCharacter(kana: "ぢ", romaji: "ji", type: .hiragana),
        KanaCharacter(kana: "づ", romaji: "zu", type: .hiragana),
        KanaCharacter(kana: "で", romaji: "de", type: .hiragana),
        KanaCharacter(kana: "ど", romaji: "do", type: .hiragana),
        
        // ば行 (ba, bi, bu, be, bo)
        KanaCharacter(kana: "ば", romaji: "ba", type: .hiragana),
        KanaCharacter(kana: "び", romaji: "bi", type: .hiragana),
        KanaCharacter(kana: "ぶ", romaji: "bu", type: .hiragana),
        KanaCharacter(kana: "べ", romaji: "be", type: .hiragana),
        KanaCharacter(kana: "ぼ", romaji: "bo", type: .hiragana),
        
        // Handakuten variations
        // ぱ行 (pa, pi, pu, pe, po)
        KanaCharacter(kana: "ぱ", romaji: "pa", type: .hiragana),
        KanaCharacter(kana: "ぴ", romaji: "pi", type: .hiragana),
        KanaCharacter(kana: "ぷ", romaji: "pu", type: .hiragana),
        KanaCharacter(kana: "ぺ", romaji: "pe", type: .hiragana),
        KanaCharacter(kana: "ぽ", romaji: "po", type: .hiragana)
    ]
    
    private var katakanaCharacters: [KanaCharacter] = [
        // ア行 (a, i, u, e, o)
        KanaCharacter(kana: "ア", romaji: "a", type: .katakana),
        KanaCharacter(kana: "イ", romaji: "i", type: .katakana),
        KanaCharacter(kana: "ウ", romaji: "u", type: .katakana),
        KanaCharacter(kana: "エ", romaji: "e", type: .katakana),
        KanaCharacter(kana: "オ", romaji: "o", type: .katakana),
        
        // カ行 (ka, ki, ku, ke, ko)
        KanaCharacter(kana: "カ", romaji: "ka", type: .katakana),
        KanaCharacter(kana: "キ", romaji: "ki", type: .katakana),
        KanaCharacter(kana: "ク", romaji: "ku", type: .katakana),
        KanaCharacter(kana: "ケ", romaji: "ke", type: .katakana),
        KanaCharacter(kana: "コ", romaji: "ko", type: .katakana),
        
        // サ行 (sa, shi, su, se, so)
        KanaCharacter(kana: "サ", romaji: "sa", type: .katakana),
        KanaCharacter(kana: "シ", romaji: "shi", type: .katakana),
        KanaCharacter(kana: "ス", romaji: "su", type: .katakana),
        KanaCharacter(kana: "セ", romaji: "se", type: .katakana),
        KanaCharacter(kana: "ソ", romaji: "so", type: .katakana),
        
        // タ行 (ta, chi, tsu, te, to)
        KanaCharacter(kana: "タ", romaji: "ta", type: .katakana),
        KanaCharacter(kana: "チ", romaji: "chi", type: .katakana),
        KanaCharacter(kana: "ツ", romaji: "tsu", type: .katakana),
        KanaCharacter(kana: "テ", romaji: "te", type: .katakana),
        KanaCharacter(kana: "ト", romaji: "to", type: .katakana),
        
        // ナ行 (na, ni, nu, ne, no)
        KanaCharacter(kana: "ナ", romaji: "na", type: .katakana),
        KanaCharacter(kana: "ニ", romaji: "ni", type: .katakana),
        KanaCharacter(kana: "ヌ", romaji: "nu", type: .katakana),
        KanaCharacter(kana: "ネ", romaji: "ne", type: .katakana),
        KanaCharacter(kana: "ノ", romaji: "no", type: .katakana),
        
        // ハ行 (ha, hi, fu, he, ho)
        KanaCharacter(kana: "ハ", romaji: "ha", type: .katakana),
        KanaCharacter(kana: "ヒ", romaji: "hi", type: .katakana),
        KanaCharacter(kana: "フ", romaji: "fu", type: .katakana),
        KanaCharacter(kana: "ヘ", romaji: "he", type: .katakana),
        KanaCharacter(kana: "ホ", romaji: "ho", type: .katakana),
        
        // マ行 (ma, mi, mu, me, mo)
        KanaCharacter(kana: "マ", romaji: "ma", type: .katakana),
        KanaCharacter(kana: "ミ", romaji: "mi", type: .katakana),
        KanaCharacter(kana: "ム", romaji: "mu", type: .katakana),
        KanaCharacter(kana: "メ", romaji: "me", type: .katakana),
        KanaCharacter(kana: "モ", romaji: "mo", type: .katakana),
        
        // ヤ行 (ya, yu, yo)
        KanaCharacter(kana: "ヤ", romaji: "ya", type: .katakana),
        KanaCharacter(kana: "ユ", romaji: "yu", type: .katakana),
        KanaCharacter(kana: "ヨ", romaji: "yo", type: .katakana),
        
        // ラ行 (ra, ri, ru, re, ro)
        KanaCharacter(kana: "ラ", romaji: "ra", type: .katakana),
        KanaCharacter(kana: "リ", romaji: "ri", type: .katakana),
        KanaCharacter(kana: "ル", romaji: "ru", type: .katakana),
        KanaCharacter(kana: "レ", romaji: "re", type: .katakana),
        KanaCharacter(kana: "ロ", romaji: "ro", type: .katakana),
        
        // ワ行 (wa, wo)
        KanaCharacter(kana: "ワ", romaji: "wa", type: .katakana),
        KanaCharacter(kana: "ヲ", romaji: "wo", type: .katakana),
        
        // ン (n)
        KanaCharacter(kana: "ン", romaji: "n", type: .katakana),
        
        // Dakuten variations
        // ガ行 (ga, gi, gu, ge, go)
        KanaCharacter(kana: "ガ", romaji: "ga", type: .katakana),
        KanaCharacter(kana: "ギ", romaji: "gi", type: .katakana),
        KanaCharacter(kana: "グ", romaji: "gu", type: .katakana),
        KanaCharacter(kana: "ゲ", romaji: "ge", type: .katakana),
        KanaCharacter(kana: "ゴ", romaji: "go", type: .katakana),
        
        // ザ行 (za, ji/zi, zu, ze, zo)
        KanaCharacter(kana: "ザ", romaji: "za", type: .katakana),
        KanaCharacter(kana: "ジ", romaji: "ji", type: .katakana),
        KanaCharacter(kana: "ズ", romaji: "zu", type: .katakana),
        KanaCharacter(kana: "ゼ", romaji: "ze", type: .katakana),
        KanaCharacter(kana: "ゾ", romaji: "zo", type: .katakana),
        
        // ダ行 (da, ji, zu, de, do)
        KanaCharacter(kana: "ダ", romaji: "da", type: .katakana),
        KanaCharacter(kana: "ヂ", romaji: "ji", type: .katakana),
        KanaCharacter(kana: "ヅ", romaji: "zu", type: .katakana),
        KanaCharacter(kana: "デ", romaji: "de", type: .katakana),
        KanaCharacter(kana: "ド", romaji: "do", type: .katakana),
        
        // バ行 (ba, bi, bu, be, bo)
        KanaCharacter(kana: "バ", romaji: "ba", type: .katakana),
        KanaCharacter(kana: "ビ", romaji: "bi", type: .katakana),
        KanaCharacter(kana: "ブ", romaji: "bu", type: .katakana),
        KanaCharacter(kana: "ベ", romaji: "be", type: .katakana),
        KanaCharacter(kana: "ボ", romaji: "bo", type: .katakana),
        
        // Handakuten variations
        // パ行 (pa, pi, pu, pe, po)
        KanaCharacter(kana: "パ", romaji: "pa", type: .katakana),
        KanaCharacter(kana: "ピ", romaji: "pi", type: .katakana),
        KanaCharacter(kana: "プ", romaji: "pu", type: .katakana),
        KanaCharacter(kana: "ペ", romaji: "pe", type: .katakana),
        KanaCharacter(kana: "ポ", romaji: "po", type: .katakana)
    ]
    
    private(set) var currentQuestion: KanaCharacter?
    private(set) var options: [String] = []
    private(set) var score = 0
    private(set) var isLoading = false
    
    var quizMode: QuizMode = .kanaToRomaji
    var inputType: QuizInputType = .multipleChoice
    var userInput: String = ""
    var includeHiragana = true
    var includeKatakana = true
    var includeDakuten = true
    var includeHandakuten = true
    
    var showFeedback = false
    var feedbackMessage = ""
    var isCorrectAnswer = false
    
    private var availableCharacters: [KanaCharacter] {
        var characters: [KanaCharacter] = []
        
        if includeHiragana {
            let filteredHiragana = hiraganaCharacters.filter { kana in
                let isDakuten = kana.romaji.hasPrefix("g") || 
                               kana.romaji.hasPrefix("z") || 
                               kana.romaji.hasPrefix("d") || 
                               kana.romaji.hasPrefix("b")
                let isHandakuten = kana.romaji.hasPrefix("p")
                
                if !includeDakuten && isDakuten { return false }
                if !includeHandakuten && isHandakuten { return false }
                if !includeDakuten && !includeHandakuten {
                    return !isDakuten && !isHandakuten
                }
                return true
            }
            characters += filteredHiragana
        }
        
        if includeKatakana {
            let filteredKatakana = katakanaCharacters.filter { kana in
                let isDakuten = kana.romaji.hasPrefix("g") || 
                               kana.romaji.hasPrefix("z") || 
                               kana.romaji.hasPrefix("d") || 
                               kana.romaji.hasPrefix("b")
                let isHandakuten = kana.romaji.hasPrefix("p")
                
                if !includeDakuten && isDakuten { return false }
                if !includeHandakuten && isHandakuten { return false }
                if !includeDakuten && !includeHandakuten {
                    return !isDakuten && !isHandakuten
                }
                return true
            }
            characters += filteredKatakana
        }
        
        return characters.isEmpty ? hiraganaCharacters.filter { !$0.romaji.hasPrefix("g") && !$0.romaji.hasPrefix("z") && !$0.romaji.hasPrefix("d") && !$0.romaji.hasPrefix("b") && !$0.romaji.hasPrefix("p") } : characters
    }
    
    init() {
        // No async calls in init
        currentQuestion = availableCharacters.randomElement()
        generateOptions()
    }
    
    func switchQuizMode() {
        // Just regenerate options for the current question
        generateOptions()
    }
    
    func generateNewQuestion() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 100_000_000)
        currentQuestion = availableCharacters.randomElement()
        generateOptions()
        isLoading = false
    }
    
    private func generateOptions() {
        guard let currentQuestion = currentQuestion else { return }
        
        // Get the correct answer based on quiz mode
        let correctAnswer = quizMode == .kanaToRomaji ? currentQuestion.romaji : currentQuestion.kana
        
        // Create a pool of wrong answers
        let wrongAnswers = availableCharacters
            .filter { $0.kana != currentQuestion.kana } // Exclude current character
            .map { quizMode == .kanaToRomaji ? $0.romaji : $0.kana }
            .removingDuplicates() // Now this will work
        
        // Start with the correct answer
        var newOptions = [correctAnswer]
        
        // Add 3 unique wrong answers
        var remainingAnswers = Array(wrongAnswers)
        while newOptions.count < 4 && !remainingAnswers.isEmpty {
            let randomIndex = Int.random(in: 0..<remainingAnswers.count)
            let wrongAnswer = remainingAnswers.remove(at: randomIndex)
            if !newOptions.contains(wrongAnswer) {
                newOptions.append(wrongAnswer)
            }
        }
        
        // Shuffle the options
        options = newOptions.shuffled()
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        let isCorrect = answer.lowercased() == currentQuestion?.romaji.lowercased()
        isCorrectAnswer = isCorrect
        
        if isCorrect {
            score += 1
            feedbackMessage = "Correct!"
            
            // Auto-hide feedback and move to next question after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showFeedback = false
                Task { @MainActor in
                    await self.generateNewQuestion()
                }
            }
        } else {
            feedbackMessage = "Incorrect. The correct answer is \(currentQuestion?.romaji ?? "")"
            
            // Just hide feedback after 2 seconds, don't move to next question
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showFeedback = false
            }
        }
        
        showFeedback = true
        return isCorrect
    }
} 
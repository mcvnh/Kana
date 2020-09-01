//
//  Kana.swift
//
//  Created by Mac Van Anh on 8/31/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

import Foundation

public struct Kana: Equatable {

    public static let invalidKana = Kana()

    // MARK: - Properties

    public let romaji: String?
    public let katakana: String?
    public let hiragana: String?


    // MARK: - Enums

    public enum KanaType {
        case hiragana
        case katakana
        case romaji
    }

    public enum VoiceType {
        case seion
        case dakuon
        case yoon
    }

    public enum KanaError: Error {
        case characterNotFound
    }


    // MARK: - Constructors

    private init() {
        romaji = nil
        katakana = nil
        hiragana = nil
    }

    public init(romaji: String) {
        if let hiragana = Kana.toHiragana(of: romaji, in: .romaji) {
            self.romaji = romaji
            self.hiragana = hiragana
            self.katakana = Kana.toKatakana(of: romaji, in: .romaji)
        } else {
            self.romaji = nil
            self.hiragana = nil
            self.katakana = nil
        }
    }

    public init(katakana: String) {
        let romaji = Kana.toRomaji(of: katakana, in: .katakana) ?? ""
        self.init(romaji: romaji)
    }

    public init(hiragana: String) {
        let romaji = Kana.toRomaji(of: hiragana, in: .hiragana) ?? ""
        self.init(romaji: romaji)
    }


    // MARK: - Static methods and properties

    static let seionColumns = [0, 1, 3, 5, 7, 10, 11, 12, 13, 14, 15]
    static let dakuonColumns = [2, 4, 6, 8, 9]
    static let yoonColumns = [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]

    static let romajiChart: [[String]] = [
        ["a", "ka", "ga", "sa" , "za" , "ta" , "da", "na", "ha", "ba", "pa", "ma", "ya", "ra", "wa", "n", "kya", "gya", "ja", "sha", "cha", "nya", "hya", "bya", "pya", "mya", "rya"],
        ["i", "ki", "gi", "shi", "ji",  "chi", "di", "ni", "hi", "bi", "pi", "mi", ""  , "ri", ""  , "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["u", "ku", "gu", "su" , "zu" , "tsu", "du", "nu", "fu", "bu", "pu", "mu", "yu", "ru", ""  , "" , "kyu", "gyu", "ju", "shu", "chu", "nya", "hyu", "byu", "pyu", "myu", "ryu"],
        ["e", "ke", "ge", "se" , "ze" , "te" , "de", "ne", "he", "be", "pe", "me", ""  , "re", ""  , "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["o", "ko", "go", "so" , "zo" , "to" , "do", "no", "ho", "bo", "po", "mo", "yo", "ro", "wo", "" , "kyo", "gyo", "jo", "sho", "cho", "nyo", "hyo", "byo", "pyo", "myo", "ryo"],
    ]

    static let hiraganaChart: [[String]] = [
        ["あ", "か", "が", "さ", "ざ", "た", "だ", "な", "は", "ば", "ぱ", "ま", "や", "ら", "わ", "ん", "きゃ", "ぎゃ", "じゃ", "しゃ", "ちゃ", "にゃ", "ひゃ", "びゃ", "ぴゃ", "みゃ", "りゃ"],
        ["い", "き", "ぎ", "し", "じ", "ち", "ぢ", "に", "ひ", "び", "ぴ", "み", ""  , "り", "" ,  "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["う", "く", "ぐ", "す", "ず", "つ", "づ", "ぬ", "ふ", "ぶ", "ぷ", "む", "ゆ", "る", "" ,  "" , "きゅ", "ぎゅ", "じゅ", "しゅ", "ちゅ", "にゅ", "ひゅ", "びゅ", "ぴゅ", "みゅ", "りゅ"],
        ["え", "け", "げ", "せ", "ぜ", "て", "で", "ね", "へ", "べ", "ぺ", "め", ""  , "れ", "" ,  "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["お", "こ", "ご", "そ", "ぞ", "と", "ど", "の", "ほ", "ぼ", "ぽ", "も", "よ", "ろ", "を",  "" , "きょ", "ぎょ", "じょ", "しょ", "ちょ", "にょ", "ひょ", "びょ", "ぴょ", "にょ", "りょ"],
    ]

    static let katakanaChart: [[String]] = [
        ["ア", "カ", "ガ", "サ", "ザ", "タ", "ダ", "ナ", "ハ", "バ", "パ", "マ", "ヤ", "ユ", "ワ", "ン", "キャ", "ギャ", "ジャ", "シャ", "チャ", "ニャ", "ヒャ", "ビャ", "ピャ", "ニャ", "リャ"],
        ["イ", "キ", "ギ", "シ", "ジ", "チ", "ヂ", "ニ", "ヒ", "ビ", "ピ", "ミ", ""  , "リ", ""  , "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["ウ", "ク", "グ", "ス", "ズ", "ツ", "ヅ", "ヌ", "フ", "ブ", "プ", "ム", "ユ", "ル", ""  , "" , "キュ", "ギュ", "ジュ", "シュ", "チュ", "ニュ", "ヒュ", "ビュ", "ピュ", "ニュ", "リュ"],
        ["エ", "ケ", "ゲ", "セ", "ゼ", "テ", "デ", "ネ", "ヘ", "ベ", "ペ", "メ", ""  , "レ", ""  , "" , "", "", "", "", "", "", "", "", "", "", ""],
        ["オ", "コ", "ゴ", "ソ", "ゾ", "ト", "ド", "ノ", "ホ", "ボ", "ポ", "モ", "ヨ", "ロ", "ヲ" , "" , "キョ", "ギョ", "ジョ", "ショ", "チョ", "ニョ", "ヒョ", "ビョ", "ピョ", "ニョ", "リョ"],
    ]

    public static func getTable(_ of: VoiceType) -> KanaTable {
        var columns: [Int]?

        switch of {
        case .seion:
            columns = seionColumns
        case .dakuon:
            columns = dakuonColumns
        case .yoon:
            columns = yoonColumns
        }

        var kanaTable: [[Kana]] = []
        for i in 0..<romajiChart.count {
            kanaTable.append([])
            for j in columns! {
                let romaji = romajiChart[i][j]
                let kana = Kana(romaji: romaji)
                kanaTable[i].append(kana)
            }
        }

        return KanaTable(values: kanaTable)
    }

    public static func toRomaji(of character: String, in type: KanaType) -> String? {
        if !character.isEmpty {
            let chart = type == .hiragana
                ? hiraganaChart
                : katakanaChart

            for row in 0..<chart.count {
                if let col = chart[row].firstIndex(of: character) {
                    return romajiChart[row][col]
                }
            }
        }

        return nil
    }

    public static func toKatakana(of character: String, in type: KanaType) -> String? {
        if !character.isEmpty {
            let chart = type == .hiragana
                ? hiraganaChart
                : romajiChart

            for row in 0..<chart.count {
                if let col = chart[row].firstIndex(of: character) {
                    return katakanaChart[row][col]
                }
            }
        }

        return nil
    }

    public static func toHiragana(of character: String, in type: KanaType) -> String? {
        if !character.isEmpty {
            let chart = type == .katakana
                ? katakanaChart
                : romajiChart

            for row in 0..<chart.count {
                if let col = chart[row].firstIndex(of: character) {
                    return hiraganaChart[row][col]
                }
            }
        }

        return nil
    }

    public static func convert(_ input: String, to kana: Kana.KanaType) -> String {
        let trimmed: String = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let tokenizer: CFStringTokenizer =
            CFStringTokenizerCreate(kCFAllocatorDefault,
                                    trimmed as CFString,
                                    CFRangeMake(0, trimmed.utf16.count),
                                    kCFStringTokenizerUnitWordBoundary,
                                    Locale(identifier: "ja") as CFLocale)

        switch kana {
        case .hiragana:
            return tokenizer.hiragana
        case .katakana:
            return tokenizer.katakana
        case .romaji:
            let hiragana = Array(tokenizer.hiragana)
            var translated: String = ""

            for i in 0..<hiragana.count {
                if ["ゃ", "ょ", "ゅ"].firstIndex(of: hiragana[i]) != nil {
                    continue
                }
                
                if i + 1 < hiragana.count {
                    if ["ゃ", "ょ", "ゅ"].firstIndex(of: hiragana[i + 1]) != nil {
                        let gyon: String = "\(hiragana[i])\(hiragana[i + 1])"
                        let romaji = Kana.toRomaji(of: gyon, in: .hiragana)!
                        translated += romaji
                        continue
                    }
                }

                let romaji = Kana.toRomaji(of: String(hiragana[i]), in: .hiragana) ?? String(hiragana[i])
                translated += romaji
            }

            return translated
        }
    }

    public static func random(in voiceType: VoiceType) -> Kana {
        let table = getTable(voiceType)
        var randomKana: Kana?

        while true {
            let row = Int.random(in: 0..<table.count)
            let col = Int.random(in: 0..<table[row].count)

            if table[row][col] != invalidKana {
                randomKana = table[row][col]
                break
            }
        }

        return randomKana!
    }

    public static func random(in voiceType: VoiceType, count number: Int) -> [Kana] {
        return (0..<number).map { _ in
            Kana.random(in: voiceType)
        }
    }
}

fileprivate extension CFStringTokenizer {
    var hiragana: String { string(to: kCFStringTransformLatinHiragana) }
    var katakana: String { string(to: kCFStringTransformLatinKatakana) }

    private func string(to transform: CFString) -> String {
        var output: String = ""
        while !CFStringTokenizerAdvanceToNextToken(self).isEmpty {
            output.append(letter(to: transform))
        }
        return output
    }

    private func letter(to transform: CFString) -> String {
        let mutableString: NSMutableString =
            CFStringTokenizerCopyCurrentTokenAttribute(self, kCFStringTokenizerAttributeLatinTranscription)
                .flatMap { $0 as? NSString }
                .map { $0.mutableCopy() }
                .flatMap { $0 as? NSMutableString } ?? NSMutableString()

        CFStringTransform(mutableString, nil, transform, false)

        return mutableString as String
    }
}


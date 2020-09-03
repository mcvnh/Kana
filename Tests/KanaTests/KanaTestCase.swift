//
//  KanaTestCase.swift
//
//  Created by Mac Van Anh on 8/31/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

import XCTest
@testable import Kana

final class KanaTestCase: XCTestCase {
    func test_toRomaji() {
        XCTAssertEqual(Kana.toRomaji(of: "ア", in: .katakana), "a")
        XCTAssertEqual(Kana.toRomaji(of: "ギョ", in: .katakana), "gyo")
        XCTAssertEqual(Kana.toRomaji(of: "ボ", in: .katakana), "bo")

        XCTAssertEqual(Kana.toRomaji(of: "ん", in: .hiragana), "n")
        XCTAssertEqual(Kana.toRomaji(of: "ぎゃ", in: .hiragana), "gya")
        XCTAssertEqual(Kana.toRomaji(of: "ぼ", in: .hiragana), "bo")

        XCTAssertNil(Kana.toRomaji(of: "", in: .hiragana))
        XCTAssertNil(Kana.toRomaji(of: "ab", in: .romaji))
        XCTAssertNil(Kana.toRomaji(of: "  ", in: .katakana))
    }

    func test_toKatakana() {
        XCTAssertEqual(Kana.toKatakana(of: "あ", in: .hiragana), "ア")
        XCTAssertEqual(Kana.toKatakana(of: "びょ", in: .hiragana), "ビョ")

        XCTAssertEqual(Kana.toKatakana(of: "n", in: .romaji), "ン")
        XCTAssertEqual(Kana.toKatakana(of: "byo", in: .romaji), "ビョ")

        XCTAssertNil(Kana.toKatakana(of: "", in: .hiragana))
        XCTAssertNil(Kana.toKatakana(of: "ab", in: .romaji))
        XCTAssertNil(Kana.toKatakana(of: "  ", in: .katakana))
    }

    func test_toHiragana() {
        XCTAssertEqual(Kana.toHiragana(of: "ン", in: .katakana), "ん")
        XCTAssertEqual(Kana.toHiragana(of: "ビョ", in: .katakana), "びょ")

        XCTAssertEqual(Kana.toHiragana(of: "tsu", in: .romaji), "つ")
        XCTAssertEqual(Kana.toHiragana(of: "po", in: .romaji), "ぽ")

        XCTAssertNil(Kana.toHiragana(of: "", in: .hiragana))
        XCTAssertNil(Kana.toHiragana(of: "ab", in: .romaji))
        XCTAssertNil(Kana.toHiragana(of: "  ", in: .katakana))
    }

    func test_initFromRomaji() {
        XCTAssertEqual(Kana(romaji: "a").hiragana, "あ")
        XCTAssertEqual(Kana(romaji: "a").katakana, "ア")

        XCTAssertTrue(Kana(romaji: "").isInvalid)
        XCTAssertTrue(Kana(romaji: " ").isInvalid)
        XCTAssertTrue(Kana(romaji: "world").isInvalid)
    }

    func test_initFromHiragana() {
        let character = Kana(hiragana: "む")

        XCTAssertEqual(character.katakana, "ム")
        XCTAssertEqual(character.romaji, "mu")

        XCTAssertTrue(Kana(hiragana: "").isInvalid)
        XCTAssertTrue(Kana(hiragana: " ").isInvalid)
        XCTAssertTrue(Kana(hiragana: "world").isInvalid)
    }

    func test_initFromKatakana() {
        let character = Kana(katakana: "カ")

        XCTAssertEqual(character.hiragana, "か")
        XCTAssertEqual(character.romaji, "ka")

        XCTAssertTrue(Kana(katakana: "").isInvalid)
        XCTAssertTrue(Kana(katakana: " ").isInvalid)
        XCTAssertTrue(Kana(katakana: "world").isInvalid)
    }

    func test_convert() {
        let input = "相葉雅紀ひらカタ"
        let output = Kana.convert(input, to: .hiragana)
        XCTAssertEqual(output, "あいばまさきひらかた")

        let anotherInput = "櫻井翔カタかな"
        let anotherOutput = Kana.convert(anotherInput, to: .katakana)
        XCTAssertEqual(anotherOutput, "サクライショウカタカナ")

        let inputWithSpaces = "相葉雅紀　ひらカタ"
        let romajiOutput = Kana.convert(inputWithSpaces, to: .romaji)
        XCTAssertEqual(romajiOutput, "aibamasakihirakata")

        let inputWithNumbers = "相葉雅紀 12 ひらカタ"
        let outputWithNumbers = Kana.convert(inputWithNumbers, to: .romaji)
        XCTAssertEqual(outputWithNumbers, "aibamasaki12hirakata")

        let inputWithGyon = anotherInput
        let outputWithGyon = Kana.convert(inputWithGyon, to: .romaji)
        XCTAssertEqual(outputWithGyon, "sakuraishoukatakana")
    }

    func test_randomInVoiceType() {
        let randomKana = Kana.random(with: KanaColumns.seion)

        XCTAssertNotEqual(randomKana.romaji, "")
        XCTAssertNotEqual(randomKana.hiragana, "")
        XCTAssertNotEqual(randomKana.katakana, "")

        let randomKanas = Kana.random(with: KanaColumns.seion, count: 3)
        XCTAssertEqual(randomKanas.count, 3)

        let uniqRandomKanas = Kana.random(with: KanaColumns.seion, count: 3, uniq: true)
        XCTAssertEqual(uniqRandomKanas.count, 3)
    }

    func test_randomInVoiceTypes() {
        let randomKana = Kana.random(with: KanaColumns.seion + KanaColumns.dakuon)

        XCTAssertNotEqual(randomKana.romaji, "")
        XCTAssertNotEqual(randomKana.hiragana, "")
        XCTAssertNotEqual(randomKana.katakana, "")

        let randomKanas = Kana.random(with: KanaColumns.seion + KanaColumns.dakuon, count: 3)
        XCTAssertEqual(randomKanas.count, 3)

        let uniqRandomKanas = Kana.random(with: KanaColumns.seion + KanaColumns.dakuon, count: 3, uniq: true)
        XCTAssertEqual(uniqRandomKanas.count, 3)
    }


    func test_table() {
        func withoutEmpty(_ table: KanaTable) -> Int {
            var count = 0
            table.values.forEach { row in
                row.forEach { kana in
                    if kana.isValid {
                        count += 1
                    }
                }
            }

            return count
        }

        let seion = Kana.getTable(with: KanaColumns.seion)
        let numberOfSeionWithEmptyCells = seion.count * seion[0].count
        let numberOfSeions = withoutEmpty(seion)

        XCTAssertEqual(numberOfSeionWithEmptyCells, 55)
        XCTAssertEqual(numberOfSeions, 46)

        let dakuon = Kana.getTable(with: KanaColumns.dakuon)
        let numberOfDakuonWithEmptyCells = dakuon.count * dakuon[0].count
        let numberOfDakuons = withoutEmpty(dakuon)

        XCTAssertEqual(numberOfDakuonWithEmptyCells, 25)
        XCTAssertEqual(numberOfDakuons, 25)

        let yoon = Kana.getTable(with: KanaColumns.yoon)
        let numberOfYoonWithEmptyCells = yoon.count * yoon[0].count
        let numberOfYoons = withoutEmpty(yoon)

        XCTAssertEqual(numberOfYoonWithEmptyCells, 55)
        XCTAssertEqual(numberOfYoons, 33)
    }
}

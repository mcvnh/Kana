//
//  File.swift
//  
//
//  Created by Mac Van Anh on 9/1/20.
//

import XCTest
@testable import Kana

final class KanaTableTestCase: XCTestCase {
    override func setUp() {
        self.continueAfterFailure = true
    }

    func test_subscript() {
        let kanaTable = KanaTable(values: [[Kana(romaji: "a")]])

        XCTAssertEqual(kanaTable[0].count, kanaTable.values[0].count)
        XCTAssertEqual(kanaTable[0][0], kanaTable.values[0][0])
    }

    func test_plusOperator() {
        let t1 = KanaTable(values: [[Kana(romaji: "a")]])
        let t2 = KanaTable(values: [[Kana(romaji: "i")]])

        let t3 = t1 + t2

        XCTAssertEqual(t3.count, 1)
        XCTAssertEqual(t3[0].count, 2)
        XCTAssertEqual(t3[0][0].romaji, "a")
        XCTAssertEqual(t3[0][1].romaji, "i")
    }
}

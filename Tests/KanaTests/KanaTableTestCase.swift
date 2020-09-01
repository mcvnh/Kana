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
}

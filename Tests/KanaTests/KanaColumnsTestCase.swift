//
//  KanaColumnsTestCase.swift
//  
//
//  Created by Mac Van Anh on 9/3/20.
//

import XCTest
@testable import Kana

final class KanaColumnsTestCase: XCTestCase {
    func test_seionColumns() {
        let seionColumns = [0, 1, 3, 5, 7, 8, 11, 12, 13, 14, 15]

        XCTAssertEqual(seionColumns, KanaColumns.seion.map { $0.rawValue })
    }

    func test_dakuonColumns() {
        let dakuonColumns = [2, 4, 6, 9, 10]

        XCTAssertEqual(dakuonColumns, KanaColumns.dakuon.map { $0.rawValue })

    }

    func test_yoonColumns() {
        let yoonColumns = [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]

        XCTAssertEqual(yoonColumns, KanaColumns.yoon.map { $0.rawValue })

    }
}

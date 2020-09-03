//
//  KanaTable.swift
//  
//
//  Created by Mac Van Anh on 8/31/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

import Foundation

public struct KanaTable {
    public let values: [[Kana]]
    public var count: Int {
        return values.count
    }

    public subscript(row: Int) -> [Kana] {
        return values[row]
    }

    public static func + (left: KanaTable, right: KanaTable) -> KanaTable {
        let values: [[Kana]] = (0..<left.count).map { row in
            return left[row] + right[row]
        }

        return KanaTable(values: values)
    }
}


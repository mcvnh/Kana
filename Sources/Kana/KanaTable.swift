//
//  KanaTable.swift
//  
//
//  Created by Mac Van Anh on 8/31/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

import Foundation

public struct KanaTable {
    let values: [[Kana]]
    var count: Int {
        return values.count
    }

    subscript(row: Int) -> [Kana] {
        return values[row]
    }
}


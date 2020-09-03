//
//  KanaColumns.swift
//
//
//  Created by Mac Van Anh on 8/31/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//


import Foundation

public struct KanaColumns {

    public enum Keys: Int {
        case a = 0, ka, ga, sa , za , ta , da, na, ha, ba, pa, ma, ya, ra, wa, n, kya, gya, ja, sha, cha, nya, hya, bya, pya, mya, rya
    }

    public static var seion: [KanaColumns.Keys] {
        return [.a, .ka, .sa, .ta, .na, .ha, .ma, .ya, .ra, .wa, .n]
    }

    public static var dakuon: [KanaColumns.Keys] {
        return [.ga, .za, .da, .ba, .pa]
    }

    public static var yoon: [KanaColumns.Keys] {
        return [.kya, .gya, .ja, .sha, .cha, .nya, .hya, .bya, .pya, .mya, .rya]
    }

}

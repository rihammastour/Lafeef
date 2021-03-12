//
//  TimeInterval+Int.swift
//  Lafeef
//
//  Created by Renad nasser on 12/03/2021.
//

import Foundation
import SpriteKit

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

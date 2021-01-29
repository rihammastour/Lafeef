//
//  Shapes.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import Foundation
import UIKit

class Shapes{
    
static func drawBlueWave() -> UIBezierPath {
    
    let union_52Path = UIBezierPath()
    union_52Path.move(to: CGPoint(x: 331.8, y: 336.87))
    union_52Path.addCurve(to: CGPoint(x: 243.03, y: 253.33), controlPoint1: CGPoint(x: 292.8, y: 329.73), controlPoint2: CGPoint(x: 286.45, y: 273.28))
    union_52Path.addCurve(to: CGPoint(x: 106.01, y: 290.92), controlPoint1: CGPoint(x: 199.89, y: 233.51), controlPoint2: CGPoint(x: 171.63, y: 287.39))
    union_52Path.addCurve(to: CGPoint(x: 0.01, y: 256.86), controlPoint1: CGPoint(x: 63.55, y: 293.2), controlPoint2: CGPoint(x: 26.94, y: 275.41))
    union_52Path.addLine(to: CGPoint(x: 0.01, y: 192.66))
    union_52Path.addCurve(to: CGPoint(x: 0.01, y: 192), controlPoint1: CGPoint(x: 0.01, y: 192.44), controlPoint2: CGPoint(x: 0.01, y: 192.22))
    union_52Path.addLine(to: CGPoint(x: 0.01, y: 41))
    union_52Path.addLine(to: CGPoint(x: 0.01, y: 41))
    union_52Path.addCurve(to: CGPoint(x: 41.01, y: 0), controlPoint1: CGPoint(x: 0.01, y: 18.36), controlPoint2: CGPoint(x: 18.36, y: 0))
    union_52Path.addLine(to: CGPoint(x: 368.01, y: 0))
    union_52Path.addLine(to: CGPoint(x: 368.01, y: 0))
    union_52Path.addCurve(to: CGPoint(x: 409.01, y: 41), controlPoint1: CGPoint(x: 390.65, y: 0), controlPoint2: CGPoint(x: 409.01, y: 18.36))
    union_52Path.addLine(to: CGPoint(x: 409.01, y: 192))
    union_52Path.addCurve(to: CGPoint(x: 409, y: 192.95), controlPoint1: CGPoint(x: 409.01, y: 192.32), controlPoint2: CGPoint(x: 409.01, y: 192.63))
    union_52Path.addLine(to: CGPoint(x: 409, y: 293.99))
    union_52Path.addCurve(to: CGPoint(x: 339.71, y: 337.58), controlPoint1: CGPoint(x: 390.62, y: 315.24), controlPoint2: CGPoint(x: 365.62, y: 337.58))
    union_52Path.addLine(to: CGPoint(x: 339.67, y: 337.58))
    union_52Path.addCurve(to: CGPoint(x: 332.07, y: 336.91), controlPoint1: CGPoint(x: 337.12, y: 337.58), controlPoint2: CGPoint(x: 334.58, y: 337.36))
    union_52Path.addLine(to: CGPoint(x: 331.8, y: 336.87))
    union_52Path.close()
    union_52Path.fill()
    
    return union_52Path
}
    
    static func drawWhiteWave() -> UIBezierPath{
        
        let fillColor2 = UIColor(red: 0.980, green: 0.976, blue: 0.957, alpha: 1.000)
        let subtraction_4Path = UIBezierPath()

        subtraction_4Path.move(to: CGPoint(x: 358, y: 297.56))
        subtraction_4Path.addLine(to: CGPoint(x: 51, y: 297.56))
        subtraction_4Path.addLine(to: CGPoint(x: 50.9, y: 297.56))
        subtraction_4Path.addCurve(to: CGPoint(x: 31.1, y: 293.53), controlPoint1: CGPoint(x: 44.1, y: 297.56), controlPoint2: CGPoint(x: 37.36, y: 296.19))
        subtraction_4Path.addLine(to: CGPoint(x: 31.07, y: 293.52))
        subtraction_4Path.addCurve(to: CGPoint(x: 14.98, y: 282.67), controlPoint1: CGPoint(x: 25.06, y: 290.97), controlPoint2: CGPoint(x: 19.6, y: 287.28))
        subtraction_4Path.addLine(to: CGPoint(x: 14.89, y: 282.58))
        subtraction_4Path.addCurve(to: CGPoint(x: 4.04, y: 266.49), controlPoint1: CGPoint(x: 10.27, y: 277.96), controlPoint2: CGPoint(x: 6.59, y: 272.5))
        subtraction_4Path.addLine(to: CGPoint(x: 4.03, y: 266.46))
        subtraction_4Path.addCurve(to: CGPoint(x: 0, y: 246.66), controlPoint1: CGPoint(x: 1.37, y: 260.2), controlPoint2: CGPoint(x: 0, y: 253.47))
        subtraction_4Path.addLine(to: CGPoint(x: 0, y: -50.09))
        subtraction_4Path.addCurve(to: CGPoint(x: 0, y: -49.92), controlPoint1: CGPoint(x: 0, y: -50.03), controlPoint2: CGPoint(x: 0, y: -49.98))
        subtraction_4Path.addCurve(to: CGPoint(x: 0, y: -49.78), controlPoint1: CGPoint(x: 0, y: -49.87), controlPoint2: CGPoint(x: 0, y: -49.83))
        subtraction_4Path.addLine(to: CGPoint(x: 0, y: 14.42))
        subtraction_4Path.addLine(to: CGPoint(x: -1.25, y: 13.55))
        subtraction_4Path.addCurve(to: CGPoint(x: 19.87, y: 26.75), controlPoint1: CGPoint(x: 5.56, y: 18.32), controlPoint2: CGPoint(x: 12.61, y: 22.72))
        subtraction_4Path.addLine(to: CGPoint(x: 19.98, y: 26.81))
        subtraction_4Path.addCurve(to: CGPoint(x: 44.7, y: 38.34), controlPoint1: CGPoint(x: 27.94, y: 31.22), controlPoint2: CGPoint(x: 36.2, y: 35.07))
        subtraction_4Path.addLine(to: CGPoint(x: 44.55, y: 38.28))
        subtraction_4Path.addCurve(to: CGPoint(x: 71.91, y: 46.12), controlPoint1: CGPoint(x: 53.42, y: 41.68), controlPoint2: CGPoint(x: 62.58, y: 44.31))
        subtraction_4Path.addLine(to: CGPoint(x: 69.08, y: 45.55))
        subtraction_4Path.addCurve(to: CGPoint(x: 96.38, y: 48.66), controlPoint1: CGPoint(x: 78.06, y: 47.46), controlPoint2: CGPoint(x: 87.2, y: 48.5))
        subtraction_4Path.addCurve(to: CGPoint(x: 106.01, y: 48.48), controlPoint1: CGPoint(x: 101.07, y: 48.68), controlPoint2: CGPoint(x: 103.56, y: 48.61))
        subtraction_4Path.addLine(to: CGPoint(x: 105.45, y: 48.51))
        subtraction_4Path.addCurve(to: CGPoint(x: 146.23, y: 39.47), controlPoint1: CGPoint(x: 119.45, y: 47.78), controlPoint2: CGPoint(x: 133.23, y: 44.72))
        subtraction_4Path.addCurve(to: CGPoint(x: 178.54, y: 23.38), controlPoint1: CGPoint(x: 158.23, y: 34.72), controlPoint2: CGPoint(x: 168.55, y: 28.95))
        subtraction_4Path.addCurve(to: CGPoint(x: 201.56, y: 11.59), controlPoint1: CGPoint(x: 186.55, y: 18.91), controlPoint2: CGPoint(x: 194.12, y: 14.69))
        subtraction_4Path.addCurve(to: CGPoint(x: 223.9, y: 6.52), controlPoint1: CGPoint(x: 209.87, y: 8.13), controlPoint2: CGPoint(x: 216.97, y: 6.52))
        subtraction_4Path.addLine(to: CGPoint(x: 223.68, y: 6.52))
        subtraction_4Path.addCurve(to: CGPoint(x: 242.72, y: 10.74), controlPoint1: CGPoint(x: 230.26, y: 6.52), controlPoint2: CGPoint(x: 236.76, y: 7.96))
        subtraction_4Path.addLine(to: CGPoint(x: 243.34, y: 11.03))
        subtraction_4Path.addCurve(to: CGPoint(x: 257.26, y: 19.56), controlPoint1: CGPoint(x: 248.29, y: 13.34), controlPoint2: CGPoint(x: 252.96, y: 16.2))
        subtraction_4Path.addLine(to: CGPoint(x: 257.2, y: 19.51))
        subtraction_4Path.addCurve(to: CGPoint(x: 268.89, y: 30.42), controlPoint1: CGPoint(x: 261.41, y: 22.8), controlPoint2: CGPoint(x: 265.32, y: 26.45))
        subtraction_4Path.addCurve(to: CGPoint(x: 287.89, y: 55.71), controlPoint1: CGPoint(x: 276.15, y: 38.41), controlPoint2: CGPoint(x: 282.11, y: 47.2))
        subtraction_4Path.addCurve(to: CGPoint(x: 306.92, y: 80.51), controlPoint1: CGPoint(x: 294.11, y: 64.88), controlPoint2: CGPoint(x: 300, y: 73.55))
        subtraction_4Path.addLine(to: CGPoint(x: 306.77, y: 80.36))
        subtraction_4Path.addCurve(to: CGPoint(x: 317.93, y: 89.23), controlPoint1: CGPoint(x: 310.09, y: 83.79), controlPoint2: CGPoint(x: 313.84, y: 86.77))
        subtraction_4Path.addLine(to: CGPoint(x: 318.43, y: 89.53))
        subtraction_4Path.addCurve(to: CGPoint(x: 331.99, y: 94.46), controlPoint1: CGPoint(x: 322.63, y: 91.95), controlPoint2: CGPoint(x: 327.22, y: 93.62))
        subtraction_4Path.addLine(to: CGPoint(x: 332.03, y: 94.47))
        subtraction_4Path.addCurve(to: CGPoint(x: 339.69, y: 95.14), controlPoint1: CGPoint(x: 334.56, y: 94.91), controlPoint2: CGPoint(x: 337.12, y: 95.14))
        subtraction_4Path.addLine(to: CGPoint(x: 339.98, y: 95.13))
        subtraction_4Path.addCurve(to: CGPoint(x: 359.01, y: 91.26), controlPoint1: CGPoint(x: 346.5, y: 95.02), controlPoint2: CGPoint(x: 352.96, y: 93.71))
        subtraction_4Path.addLine(to: CGPoint(x: 359.17, y: 91.2))
        subtraction_4Path.addCurve(to: CGPoint(x: 377.77, y: 80.89), controlPoint1: CGPoint(x: 365.77, y: 88.53), controlPoint2: CGPoint(x: 372.01, y: 85.07))
        subtraction_4Path.addLine(to: CGPoint(x: 376.47, y: 81.81))
        subtraction_4Path.addCurve(to: CGPoint(x: 394.15, y: 67.24), controlPoint1: CGPoint(x: 382.74, y: 77.43), controlPoint2: CGPoint(x: 388.65, y: 72.55))
        subtraction_4Path.addCurve(to: CGPoint(x: 408.99, y: 51.55), controlPoint1: CGPoint(x: 398.94, y: 62.68), controlPoint2: CGPoint(x: 403.96, y: 57.37))
        subtraction_4Path.addLine(to: CGPoint(x: 408.99, y: -49.5))
        subtraction_4Path.addCurve(to: CGPoint(x: 409, y: -50.44), controlPoint1: CGPoint(x: 409, y: -49.79), controlPoint2: CGPoint(x: 409, y: -50.1))
        subtraction_4Path.addLine(to: CGPoint(x: 409, y: -192))
        subtraction_4Path.addCurve(to: CGPoint(x: 409, y: -191.72), controlPoint1: CGPoint(x: 409, y: -191.91), controlPoint2: CGPoint(x: 409, y: -191.81))
        subtraction_4Path.addLine(to: CGPoint(x: 409, y: 246.56))
        subtraction_4Path.addLine(to: CGPoint(x: 409.01, y: 246.66))
        subtraction_4Path.addCurve(to: CGPoint(x: 404.98, y: 266.46), controlPoint1: CGPoint(x: 409.01, y: 253.46), controlPoint2: CGPoint(x: 407.63, y: 260.2))
        subtraction_4Path.addLine(to: CGPoint(x: 404.96, y: 266.49))
        subtraction_4Path.addCurve(to: CGPoint(x: 394.11, y: 282.57), controlPoint1: CGPoint(x: 402.41, y: 272.5), controlPoint2: CGPoint(x: 398.73, y: 277.96))
        subtraction_4Path.addLine(to: CGPoint(x: 394.02, y: 282.67))
        subtraction_4Path.addCurve(to: CGPoint(x: 377.94, y: 293.52), controlPoint1: CGPoint(x: 389.41, y: 287.28), controlPoint2: CGPoint(x: 383.95, y: 290.97))
        subtraction_4Path.addLine(to: CGPoint(x: 377.9, y: 293.53))
        subtraction_4Path.addCurve(to: CGPoint(x: 358.1, y: 297.56), controlPoint1: CGPoint(x: 371.64, y: 296.19), controlPoint2: CGPoint(x: 364.9, y: 297.56))
        subtraction_4Path.addLine(to: CGPoint(x: 358, y: 297.56))
        subtraction_4Path.close()
        fillColor2.setFill()
        subtraction_4Path.fill()
        
        return subtraction_4Path

    }

}

//
//  IconSVG.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI

struct IconSVG: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.39054 * width, y: 0.05033 * height))
        path.addCurve(
            to: CGPoint(x: 0.49734 * width, y: 0.02546 * height),
            control1: CGPoint(x: 0.44567 * width, y: 0.03556 * height),
            control2: CGPoint(x: 0.47206 * width, y: 0.02852 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.75849 * width, y: 0.09544 * height),
            control1: CGPoint(x: 0.59016 * width, y: 0.01424 * height),
            control2: CGPoint(x: 0.68372 * width, y: 0.03931 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.83855 * width, y: 0.17037 * height),
            control1: CGPoint(x: 0.77886 * width, y: 0.11073 * height),
            control2: CGPoint(x: 0.79819 * width, y: 0.13001 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.91349 * width, y: 0.25044 * height),
            control1: CGPoint(x: 0.87891 * width, y: 0.21074 * height),
            control2: CGPoint(x: 0.89819 * width, y: 0.23007 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.98346 * width, y: 0.51158 * height),
            control1: CGPoint(x: 0.96961 * width, y: 0.32521 * height),
            control2: CGPoint(x: 0.99468 * width, y: 0.41876 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.95859 * width, y: 0.61838 * height),
            control1: CGPoint(x: 0.9804 * width, y: 0.53687 * height),
            control2: CGPoint(x: 0.97337 * width, y: 0.56325 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.92673 * width, y: 0.72332 * height),
            control1: CGPoint(x: 0.94382 * width, y: 0.67352 * height),
            control2: CGPoint(x: 0.93672 * width, y: 0.69989 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.73556 * width, y: 0.91448 * height),
            control1: CGPoint(x: 0.89004 * width, y: 0.80931 * height),
            control2: CGPoint(x: 0.82155 * width, y: 0.8778 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.63062 * width, y: 0.94635 * height),
            control1: CGPoint(x: 0.71213 * width, y: 0.92448 * height),
            control2: CGPoint(x: 0.68576 * width, y: 0.93158 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.52382 * width, y: 0.97122 * height),
            control1: CGPoint(x: 0.57549 * width, y: 0.96113 * height),
            control2: CGPoint(x: 0.54911 * width, y: 0.96816 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.26268 * width, y: 0.90125 * height),
            control1: CGPoint(x: 0.43101 * width, y: 0.98245 * height),
            control2: CGPoint(x: 0.33744 * width, y: 0.95738 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.18262 * width, y: 0.82631 * height),
            control1: CGPoint(x: 0.24231 * width, y: 0.88596 * height),
            control2: CGPoint(x: 0.22298 * width, y: 0.86667 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.10768 * width, y: 0.74624 * height),
            control1: CGPoint(x: 0.14225 * width, y: 0.78595 * height),
            control2: CGPoint(x: 0.12297 * width, y: 0.76662 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.0377 * width, y: 0.4851 * height),
            control1: CGPoint(x: 0.05155 * width, y: 0.67148 * height),
            control2: CGPoint(x: 0.02648 * width, y: 0.57792 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.06257 * width, y: 0.3783 * height),
            control1: CGPoint(x: 0.04076 * width, y: 0.45982 * height),
            control2: CGPoint(x: 0.0478 * width, y: 0.43343 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.09444 * width, y: 0.27337 * height),
            control1: CGPoint(x: 0.07735 * width, y: 0.32316 * height),
            control2: CGPoint(x: 0.08444 * width, y: 0.2968 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.28561 * width, y: 0.0822 * height),
            control1: CGPoint(x: 0.13112 * width, y: 0.18738 * height),
            control2: CGPoint(x: 0.19962 * width, y: 0.11888 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.39054 * width, y: 0.05033 * height),
            control1: CGPoint(x: 0.30904 * width, y: 0.0722 * height),
            control2: CGPoint(x: 0.33541 * width, y: 0.0651 * height)
        )
            path.closeSubpath()
            return path
        }
}

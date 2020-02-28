//
//  GithubColors.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit

class GithubColors {
    private static func getColor(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let rgb = UInt32(hex, radix: 16) ?? 0
        let r = CGFloat(Float((rgb >> 16) & 0xFF) / Float(0xFF))
        let g = CGFloat(Float((rgb >> 8) & 0xFF) / Float(0xFF))
        let b = CGFloat(Float(rgb & 0xFF) / Float(0xFF))
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    class Table: NSObject {
        static let cellBkg = getColor(hex: "2B2D36")
        static let cellTitle = getColor(hex: "EDB01A")
        static let cellFullTitle = getColor(hex: "FFFFFF")
        static let cellText = getColor(hex: "BFD0D7")
        static let cellSubtitle = getColor(hex: "BFD0D7")
        static let cellHighlight = getColor(hex: "2E4C68")
        static let separator = getColor(hex: "4D525A")
        static let checkmark = getColor(hex: "36ABFF")
        static let user = getColor(hex: "36ABFF")
    }
    
    class Main: NSObject {
        static let background = getColor(hex: "21232A")
        static let searchBarBkg = getColor(hex: "31333A")
        static let searchBarTextFieldBkg = getColor(hex: "2B2D36")
        static let searchBarTextFieldFrame = getColor(hex: "4D525A")
        static let searchBarText = getColor(hex: "BFD0D7")
        static let waitingBackground = getColor(hex: "21232A", alpha: 0.95)
        static let waitingIndicator = getColor(hex: "2E4C68")
        static let noResult = getColor(hex: "FFFFFF")
    }
}


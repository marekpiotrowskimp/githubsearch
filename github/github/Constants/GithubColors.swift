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
        @objc static let cellBkg = getColor(hex: "2B2D36")
        @objc static let cellTitleClosedByNotam = getColor(hex: "EDB01A")
        @objc static let cellSubtitle = getColor(hex: "BFD0D7")
        @objc static let cellHighlight = getColor(hex: "2E4C68")
        @objc static let separator = getColor(hex: "4D525A")
        @objc static let checkmark = getColor(hex: "36ABFF")
    }
    
    class Main: NSObject {
        @objc static let background = getColor(hex: "21232A")
        @objc static let searchBarBkg = getColor(hex: "31333A")
        @objc static let searchBarTextFieldBkg = getColor(hex: "2B2D36")
        @objc static let searchBarTextFieldFrame = getColor(hex: "4D525A")
        @objc static let searchBarText = getColor(hex: "BFD0D7")
        
    }
}


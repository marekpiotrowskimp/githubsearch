//
//  GithubFonts.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit

class GithubFonts {
    
    private static func boldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    private static func semiBoldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    private static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    private static func regularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    private static func italicFont(size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
    
    private static func lightFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    class Table: NSObject {
        static let backButton = regularFont(size: 18)
        static let titleSelection = semiBoldFont(size: 18)
        static let title = semiBoldFont(size: 18)
    }
    
    class Main: NSObject {
        static let folderTail = semiBoldFont(size: 20)
        static let header = regularFont(size: 14)
        static let searchText = regularFont(size: 14)
    }
}


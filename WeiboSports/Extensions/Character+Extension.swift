//
//  Character+Extension.swift
//  WeiboSports
//
//  Created by 96group on 4/23/22.
//

import Foundation

extension Character {
    var isSimpleEmoji: Bool {
       guard let firstProperties = unicodeScalars.first?.properties else {
         return false
       }
       return unicodeScalars.count == 1 &&
           (firstProperties.isEmojiPresentation ||
              firstProperties.generalCategory == .otherSymbol)
    }
    var isCombinedIntoEmoji: Bool {
       return unicodeScalars.count > 1 &&
              unicodeScalars.contains {
                 $0.properties.isJoinControl ||
                 $0.properties.isVariationSelector
              }
    }
    var isEmoji: Bool {
       return isSimpleEmoji || isCombinedIntoEmoji
    }
}

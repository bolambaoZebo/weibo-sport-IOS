//
//  String+Extension.swift
//  WeiboSports
//
//  Created by 96group on 4/15/22.
//

import Foundation

extension String {

    func htmlAttributedString() -> NSAttributedString? {
         guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
         guard let html = try? NSMutableAttributedString(
             data: data,
             options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
             documentAttributes: nil) else { return nil }
         return html
     }
    
    func replaceEmoji(with character: Character) -> String {
        return String(map { $0.isEmoji ? character : $0 })
    }
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}

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
}

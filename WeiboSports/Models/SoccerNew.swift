//
//  SoccerNew.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import Foundation

struct EnglishData: Codable {
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let teamLeague: String
    let titleChinese: String
    let descriptionChinese: String
    let language: String
}
struct ChineseData: Codable {
    let id: String
    let imageUrl: String
    let teamLeague: String
    let language: String
}
//struct News: Codable {
//    let isActive: Bool
//    let en: [EnglishData]
//    let zh: [ChineseData]
//}

struct NewData: Codable {
    let id: Int
    let imageUrl: String
    let title: String
    let description: String
    let category: [Int]
    let date: String
}

struct News: Codable {
    let isActive: Bool
    let data: [NewData]
}

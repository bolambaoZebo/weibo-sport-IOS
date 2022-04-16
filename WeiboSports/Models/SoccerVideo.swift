//
//  SoccerVideo.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import Foundation

struct SoccerVideo: Codable {
    var id: String?
    var competition: String?
    var title: String?
    var thumbnail: String?
    var video: String?
    var date: String?
}

struct Paging: Codable {
    var page: Int?
    var limit: Int?
    var size: Int?
}

//struct APIVideoResponse<T: Codable> : Codable {
//    var next: Paging?
//    var isActive: Bool?
//    var data: [SoccerVideo]?
//}

struct APIVideoResponse: Codable {
    var next: Paging?
    var isActive: Bool?
    var data: [SoccerVideo]?
}

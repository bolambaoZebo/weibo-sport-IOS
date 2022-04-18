//
//  BaseUrl.swift
//  WeiboSports
//
//  Created by 96group on 10/30/21.
//

import Foundation

struct BaseUrl {
//    static let soccerNewsUrl = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api")
    static let allNewsUrl = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/")
    static let soccerNewsUrl = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/soccer")
    static let horseNewsUrl = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/horse")
    
    //MARK: -
    
    static let allNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/")
    static let soccerNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/soccer")
    static let horseNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/horse")
}

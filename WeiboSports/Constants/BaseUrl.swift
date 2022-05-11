//
//  BaseUrl.swift
//  WeiboSports
//
//  Created by 96group on 10/30/21.
//

import Foundation

struct BaseUrl {
//    static let soccerNewsUrl = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api")
    static let allNewsUrlZH = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/")
    static let soccerNewsUrlZH = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/soccer")
    static let horseNewsUrlZH = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/horse")
    
    //MARK: -
    
    static let allNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/en")
    static let soccerNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/en/soccer")
    static let horseNewsUrlEN = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/en/horse")
    
    //MARK: - WebViews ENdpoint
    
    static let webviewLiveScore = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/wvLiveScore")
    
    static let webviewLiveStream = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/wvLiveStream")
    
    //MARK: - Header ENdpoint
    
    static let headerEndPoint = URL(string: "https://sleepy-turing-6de1dd.netlify.app/.netlify/functions/api/weiboSports/weiboHeader")
    
    
}

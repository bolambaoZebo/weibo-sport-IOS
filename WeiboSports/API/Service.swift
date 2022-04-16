//
//  Service.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import Foundation

extension URLSession {
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    func request<T: Codable>(url: URL?,
                             expecting: T.Type,
                             completion: @escaping (Result<T, Error>)-> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}


class APICaller {
    
    var isPaginating = false
    var page = 1
    var limit = 20
    var pageSize = 0
    
    func fetchData(pagination: Bool=false, completion: @escaping (Result<[SoccerVideo], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        
        guard let url = URL(string: "\(API.baseUrl)\(API.soccerVideoUrl)?page=\(page)&limit=\(limit)") else {
            return
        }
        
        URLSession.shared.request(url: url, expecting: APIVideoResponse.self) { [weak self] response in
            switch response {
            case .success(let video):
                DispatchQueue.main.async {
                                     
                    completion(.success(video.data!))
                    
                    guard let pageIndex = video.next?.page else {
                        return
                    }
                    self!.page = pageIndex
                    
                    if pagination {
                        self!.isPaginating = false
                    }
                }
            
            case .failure(let error):
                print(error)
            }
        }
        
        
//        ?page=3&limit=25
//        let params = "?page=3&limit=25"
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = params.data(using: .utf8)
        
//        let params = "page=1&limit=25"
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = params.data(using: .utf8)
        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if error != nil {
//                print(error.debugDescription)
//                return
//            }else if data != nil {
//                print(data)
//                let requestData = String(data: data!, encoding: .utf8)
//                print(requestData! as String)
//            }
//        }
//        task.resume()
    }
}


//        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
//            let original = [
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "orange", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf"),
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "apple", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf"),
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "avocado", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf"),
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "banana", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf")
//            ]
//            let newData = [
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "chicken", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf"),
//                SoccerVideo(id: "sdfklsdlf", competition: "dfsiodf", title: "chicken", thumbnail: "asdfsdf", video: "dhdhehd", date: "asdfasdf")
//            ]
//            completion(.success(pagination ? newData : original))
//            if pagination {
//                self.isPaginating = false
//            }
//        })

//
//  BaseAPI.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Alamofire

class BaseApi {
    static let shared = BaseApi()
    
    static let KEY = "c5fd8277-6674-4197-84d8-b68260d014b5"
    
    static let headers: HTTPHeaders = [
        "Content-Type":"application/x-www-form-urlencoded",
        "authorization" : KEY
    ]
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        let networkLogger = NetworkLogger()
        let interceptor = Interceptor()
        
        return Session(
            configuration: configuration,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    func getCards(name: String, page: Int = 1, pageSize: Int = 16, completion: @escaping ([CardModel]) -> Void) {
        var parameters: [String: Any] = [:]
        if !name.isEmpty {
            parameters["q"] = "name:\(name)"
        }
        
        parameters["page"] = page
        parameters["pageSize"] = pageSize
        
        sessionManager.request("\(ListUrls.HOST)\(ListUrls.CARDS)", method: .get, parameters: parameters).responseDecodable(of: CardsBaseModel.self) { (response) in
            guard let responseValue = response.value else {
                return completion([])
            }
            
            completion(responseValue.data)
        }
    }
    
    func getCard(id: String, completion: @escaping (CardModel?) -> Void) {
        sessionManager.request("\(ListUrls.HOST)\(ListUrls.CARDS)/\(id)", method: .get).responseDecodable(of: CardBaseModel.self) { (response) in
            guard let responseValue = response.value else {
                return completion(nil)
            }
            
            completion(responseValue.data)
        }
    }
    
    func cancelRequest(url: String) {
        sessionManager.session.getAllTasks { tasks in
            for task in tasks {
                if task.currentRequest?.url?.path.contains(url) == true {
                    task.cancel()
                    break
                }
            }
        }
    }
    
    func getOtherCards(id: String, completion: @escaping ([CardModel]) -> Void) {
        var parameters: [String: Any] = [:]
        parameters["q"] = "set.id:\(id)"
        parameters["page"] = 1
        parameters["pageSize"] = 6
        
        sessionManager.request("\(ListUrls.HOST)\(ListUrls.CARDS)", method: .get, parameters: parameters).responseDecodable(of: CardsBaseModel.self) { (response) in
            guard let responseValue = response.value else {
                return completion([])
            }
            
            completion(responseValue.data)
        }
    }
}

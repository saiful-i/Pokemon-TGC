//
//  NetworkLogger.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Alamofire

class NetworkLogger: EventMonitor {
  let queue = DispatchQueue(label: "com.icungse.PokemonTGC.networklogger")

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}

//
//  Interceptor.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Alamofire

class Interceptor: RequestInterceptor {
  let retryLimit = 5
  let retryDelay: TimeInterval = 10

  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    let response = request.task?.response as? HTTPURLResponse
    //Retry for 5xx status codes
    if
      let statusCode = response?.statusCode,
      (500...599).contains(statusCode),
      request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }
}


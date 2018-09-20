//
//  APIRequestProvider.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
class APIRequestProvider: NSObject {
    var alamoFireManager: SessionManager
    private override init() {
        alamoFireManager = SessionManager.default
    }
    static var sharedInstand: APIRequestProvider = {
        let instand = APIRequestProvider()
        return instand
    }()

    func directionRequest(_ origin: String, _ destination: String, _ key: String) -> DataRequest {
        let  urlRequest = "https://maps.googleapis.com/maps/api/directions/json?"
        var params = [String: String]()
        params["origin"] = origin
        params["destination"] = destination
        params["key"] = key
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: nil)
        
    }

}

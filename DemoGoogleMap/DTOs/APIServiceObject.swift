//
//  APIServiceObject.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
class APIServiceObject: NSObject {
    var requests = [DataRequest]()
    let serviceAgent = APIServiceAgent()
    
    /*
     *  add request to request array
     *  @param request  DataRequest
     */
    
    func addToQueue(_ request: DataRequest) {
        requests.append(request)
    }
    
    func cancelAllRequest() {
        let sessionManager = Alamofire.SessionManager.default
        if #available(iOS 9.0, *) {
            sessionManager.session.getAllTasks { (_ tasks: [URLSessionTask]) in
                for task in tasks {
                    task.cancel()
                }
            }
        } else {
            // Fallback on earlier versions
            sessionManager.session
                .getTasksWithCompletionHandler({ (sessionTasks, uploadTasks, downloadTasks) in
                    for task in sessionTasks {
                        task.cancel()
                    }
                    for task in uploadTasks {
                        task.cancel()
                    }
                    for task in downloadTasks {
                        task.cancel()
                    }
                })
        }
        for request in requests {
            request.cancel()
        }
        requests.removeAll()
    }
}

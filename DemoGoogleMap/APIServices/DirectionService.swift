//
//  DirectionService.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
enum TravelModes: String {
    case driving = "driving"
    case walking = "walking"
    case bicycling = "Bicycling"
    case transit = "transit"
}
class DirectionService: APIServiceObject {
    var direction: DirectionOverview?
    var selectLegs = [LegDTO]()
    var selectSteps = [StepDTO]()
    func getDirection(_ origin: String?, _ destination: String?, _ key: String, completion: @escaping (_ success: Bool) -> Void) {
        guard let origin: String = origin else {
            completion(false)
            return
        }
        guard let destination: String = destination else {
            completion(false)
            return
        }
        let directionRequest = APIRequestProvider.sharedInstand.directionRequest(origin, destination, key)
        serviceAgent.startRequest(directionRequest) { (json, error) in
            if error != nil {
                completion(false)
            } else {
                self.direction = DirectionOverview(json)
                if let status = self.direction?.status {
                    if status.isEqual("OK") {
                        if let legs = self.direction?.routes[0].legs {
                            self.selectLegs = legs
                        }
                        for leg in self.selectLegs {
                            for step in leg.steps {
                                self.selectSteps.append(step)
                            }
                        }
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
}

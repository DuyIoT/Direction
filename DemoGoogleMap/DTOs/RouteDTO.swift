//
//  RouteDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class RouteDTO {
    var bounds: BoundsDTO
    var copyrights: String
    var legs: [LegDTO]
    var overviewPolyline: PolylineDTO
    var summary: String
    init(_ json: JSON) {
        self.bounds = BoundsDTO(json["bounds"])
        self.copyrights = json["copyrights"].stringValue
        self.overviewPolyline = PolylineDTO(json["overview_polyline"])
        self.summary = json["summary"].stringValue
        legs = [LegDTO]()
        let data = json["legs"].arrayValue
        for item in data {
            legs.append(LegDTO(item))
        }
    }
}

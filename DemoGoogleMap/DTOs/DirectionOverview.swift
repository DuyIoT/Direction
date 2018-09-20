//
//  DerectionOverview.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class DirectionOverview {
    var geocodedWaypoints: [GeocodedWaypoint]
    var routes: [RouteDTO]
    var status: String
    init(_ json: JSON) {
        self.status = json["status"].stringValue
        geocodedWaypoints = [GeocodedWaypoint]()
        routes = [RouteDTO]()
        let dataGeocodedWaypoints = json["geocoded_waypoints"].arrayValue
        for item in dataGeocodedWaypoints {
            geocodedWaypoints.append(GeocodedWaypoint(item))
        }
        let dataRoute = json["routes"].arrayValue
        for item in dataRoute {
            routes.append(RouteDTO(item))
        }
    }
}

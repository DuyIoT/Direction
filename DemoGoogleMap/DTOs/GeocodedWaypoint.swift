//
//  GeocodedWaypoint.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class GeocodedWaypoint {
    var geocoderStatus: String
    var placeId: String
    var types: [String]
    init(_ json: JSON) {
        self.geocoderStatus = json["geocoder_status"].stringValue
        self.placeId = json["place_id"].stringValue
        types = [String]()
        let data = json["types"].arrayValue
        for item in data {
            self.types.append(item.stringValue)
        }
    }
    
}

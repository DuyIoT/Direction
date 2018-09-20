//
//  LocationDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class LocationDTO {
    var latitude = 0.0
    var longtidude = 0.0
    init(_ json: JSON) {
        self.latitude = json["lat"].doubleValue
        self.longtidude = json["lng"].doubleValue
    }
}

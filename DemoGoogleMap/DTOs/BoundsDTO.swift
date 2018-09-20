//
//  BoundsDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class BoundsDTO {
    var northeast: LocationDTO
    var southwest: LocationDTO
    init(_ json: JSON) {
        self.northeast = LocationDTO(json["northeast"])
        self.southwest = LocationDTO(json["southwest"])
    }
}

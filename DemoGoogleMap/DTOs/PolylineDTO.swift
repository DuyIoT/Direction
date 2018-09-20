//
//  PolylineDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class PolylineDTO {
    var points: String
    init(_ json: JSON) {
        self.points = json["points"].stringValue
    }
}

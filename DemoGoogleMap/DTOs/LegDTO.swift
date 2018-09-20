//
//  LegDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class LegDTO {
    var distance: GoogleValueDTO
    var duration: GoogleValueDTO
    var endLocation: LocationDTO
    var startLocation: LocationDTO
    var endAddress: String
    var polyline: PolylineDTO
    var startAddress: String
    var steps: [StepDTO]
    init(_ json: JSON) {
        self.distance = GoogleValueDTO(json["distance"])
        self.duration = GoogleValueDTO(json["duration"])
        self.endLocation = LocationDTO(json["end_location"])
        self.startLocation = LocationDTO(json["start_location"])
        self.polyline = PolylineDTO(json["polyline"])
        self.endAddress = json["end_address"].stringValue
        self.startAddress = json["start_address"].stringValue
        steps = [StepDTO]()
        let data = json["steps"].arrayValue
        for item in data {
            steps.append(StepDTO(item))
        }
    }
}

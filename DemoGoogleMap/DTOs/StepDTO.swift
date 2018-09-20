//
//  StepDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class StepDTO {
    var distance: GoogleValueDTO
    var duration: GoogleValueDTO
    var endLocation: LocationDTO
    var startLocation: LocationDTO
    var travelMode: String
    var polyline: PolylineDTO
    var htmlInstructions: String
    init(_ json: JSON) {
        self.distance = GoogleValueDTO(json["distance"])
        self.duration = GoogleValueDTO(json["duration"])
        self.endLocation = LocationDTO(json["end_location"])
        self.startLocation = LocationDTO(json["start_location"])
        self.htmlInstructions = json["html_instructions"].stringValue
        self.travelMode = json["travel_mode"].stringValue
        self.polyline = PolylineDTO(json["polyline"])
    }
}

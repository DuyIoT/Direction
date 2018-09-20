//
//  GoogleValueDTO.swift
//  DemoGoogleMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class GoogleValueDTO {
    var text: String
    var value: Int?
    init(_ json: JSON) {
        self.text = json["text"].stringValue
        self.value = json["value"].intValue
    }
}

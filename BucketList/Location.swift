//
//  Location.swift
//  BucketList
//
//  Created by Tamim Khan on 2/5/23.
//

import Foundation
import CoreLocation


struct Location: Identifiable, Codable, Equatable{
   var id: UUID
    var name: String
    var description: String
    let latitued: Double
    let longiTued: Double
    
    
    var cordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitued, longitude: longiTued)
    }
    
    static let example = Location(id: UUID(), name: "Dhaka", description: "Gotham with no BatMan", latitued: 23.8103, longiTued: 90.4125)
    
    
    static func ==(lhs: Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
}

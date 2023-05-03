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
    let latitude: Double
    let longitude: Double
    
    
    var cordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Dhaka", description: "Gotham with no BatMan", latitude: 23.8103, longitude: 90.4125)
    
    
    static func ==(lhs: Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
}

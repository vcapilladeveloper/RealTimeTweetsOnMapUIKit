//
//  CLLocation+Extension.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func convertToLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

extension CLLocation {
    func convertToLocationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}

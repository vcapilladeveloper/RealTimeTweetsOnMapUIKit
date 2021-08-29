//
//  MKMapView+Extension.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import CoreLocation
import MapKit

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    var coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    coordinateRegion.span = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    setRegion(coordinateRegion, animated: true)
  }
}

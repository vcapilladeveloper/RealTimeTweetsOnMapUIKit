//
//  MainViewModel.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation
import CoreLocation.CLLocation

class MainViewModel: NSObject {
    
    var rule = ""
    var lifeTime = 5
    var location: CLLocation?
    var lifeTimeOptions = [5, 10, 15]
    
    var updateMap: (() -> ()) = { }
    var errorState: (()->()) = { }
    
    func searchAction(_ newRule: String) {
        self.rule = newRule
    }
    
}

extension MainViewModel: APIServiceDelegate {
    func reciveLocation(_ location: CLLocation) {
        self.location = location
        updateMap()
    }
}

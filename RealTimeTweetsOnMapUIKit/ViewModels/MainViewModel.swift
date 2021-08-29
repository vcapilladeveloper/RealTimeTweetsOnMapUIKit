//
//  MainViewModel.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation
import CoreLocation.CLLocation

class MainViewModel: NSObject {
    
    private(set) var rule = ""
    private(set) var lifeTime = 5
    var location: CLLocation?
    var lifeTimeOptions = [5, 10, 15]
    
    
    
}

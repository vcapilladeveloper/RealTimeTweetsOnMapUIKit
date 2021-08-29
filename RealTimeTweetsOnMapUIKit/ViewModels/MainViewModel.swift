//
//  MainViewModel.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation
import CoreLocation.CLLocation

class MainViewModel: NSObject {

    var lifeTime = 5
    var location: CLLocation? {
        didSet {
            updateMap()
        }
    }
    var apiService = APIService()
    
    var lifeTimeOptions = [5, 10, 15]
   
    var updateMap: (() -> ()) = { }
    var errorState: ((String)->()) = { _ in }
    
    override init() {
        super.init()
        apiService.returnNewLocation = { [weak self] result in
            switch result {
            case .success(let coordinate):
                self?.location = coordinate
            case .failure(let error):
                self?.errorState(error.localizedDescription)
            }
        }
    }
    
    func searchAction(_ newRule: String) {
        apiService.fecthTweetsWith(newRule)
    }
    
}


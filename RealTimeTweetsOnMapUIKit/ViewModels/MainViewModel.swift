//
//  MainViewModel.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation
import CoreLocation.CLLocation

// View Model for manage the state of the View
class MainViewModel: NSObject {

    // MARK: - Properties
    var lifeTime = 5
    // When location is set, the updateMap action is trigger
    var location: CLLocation? {
        didSet {
            updateMap()
        }
    }
    
    // Reference to ApiService for make the request to the api
    var apiService: APIServiceProtocol

    // Life Time Options for the Map annotations
    var lifeTimeOptions = [5, 10, 15]

    // Function for inform to the view for updateMap
    var updateMap: (() -> Void) = { }
    
    // Function for inform to the view for Error
    // TODO: Apply this function to the View
    var errorState: ((String) -> Void) = { _ in }

    init(_ apiService: APIServiceProtocol) {
        self.apiService = apiService
        super.init()
        self.apiService.returnNewLocation = { [weak self] result in
            switch result {
            case .success(let coordinate):
                self?.location = coordinate
            case .failure(let error):
                self?.errorState(error.localizedDescription)
            }
        }
    }
    
    // Triggered from the View with the Rule for start the stream process
    func searchAction(_ newRule: String) {
        apiService.fecthTweetsWith(newRule)
    }

    // Triggered from the View for change the Life Time for the Annotations
    func changeLifeTime(_ index: Int) {
        if index < lifeTimeOptions.count { lifeTime = lifeTimeOptions[index] }
    }
}
